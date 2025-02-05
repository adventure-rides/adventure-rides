const express = require("express");
const cors = require("cors");
const stripe = require("stripe")("sk_test_51QcroNERybcrOMLTzWelRRiZCeKWPQ2byABmWINzipwporCNG33x31EPsttcQswZ3jWtio0c8bus8vYX4I7FbLfT00u39zl2Da"); // Replace with your Stripe Secret Key

const app = express();
app.use(cors({ origin: "*" })); // ✅ Allow all origins
app.use(express.json());

// ✅ New Route: Create Checkout Session for Web
app.post("/create-checkout-session", async (req, res) => {
    try {
        const { amount, returnUrl } = req.body; // Get return URL from Flutter request

        const session = await stripe.checkout.sessions.create({
            payment_method_types: ["card"],
            line_items: [{
                price_data: {
                    currency: "usd",
                    product_data: { name: "Safari Chat" },
                    unit_amount: amount,
                },
                quantity: 1,
            }],
            mode: "payment",
            success_url: `${returnUrl}?status=success`,  // ✅ Redirect to Flutter with success status
            cancel_url: `${returnUrl}?status=cancel`,    // ✅ Redirect to Flutter with cancel status
        });

        res.json({ url: session.url });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
