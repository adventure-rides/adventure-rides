const express = require("express");
const cors = require("cors");
const stripe = require("stripe")("sk_test_51QcroNERybcrOMLTzWelRRiZCeKWPQ2byABmWINzipwporCNG33x31EPsttcQswZ3jWtio0c8bus8vYX4I7FbLfT00u39zl2Da"); // Replace with your actual Stripe Secret Key

const app = express();
app.use(cors({ origin: "*" })); // ✅ Allow all origins
app.use(express.json());

// ✅ Default route to prevent "Cannot GET /" error
app.get("/", (req, res) => {
    res.send("🚀 Stripe Payment Server is running!");
});

// ✅ Payment Intent Route
app.post("/create-payment-intent", async (req, res) => {
    try {
        const { amount } = req.body;
        if (!amount || amount <= 0) {
            return res.status(400).json({ error: "Invalid payment amount." });
        }

        console.log(`🔹 Creating payment intent for $${amount / 100}`);

        const paymentIntent = await stripe.paymentIntents.create({
            amount, // Amount in cents (e.g., $50 = 5000)
            currency: "usd",
        });

        res.json({ clientSecret: paymentIntent.client_secret });
    } catch (error) {
        console.error("❌ Error creating payment intent:", error);
        res.status(500).json({ error: error.message });
    }
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
