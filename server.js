const express = require("express");
const cors = require("cors");
const stripe = require("stripe")("sk_test_51QcroNERybcrOMLTzWelRRiZCeKWPQ2byABmWINzipwporCNG33x31EPsttcQswZ3jWtio0c8bus8vYX4I7FbLfT00u39zl2Da");

const app = express();
app.use(cors());
app.use(express.json());

app.post("/create-payment-intent", async (req, res) => {
    try {
        const { amount } = req.body;

        const paymentIntent = await stripe.paymentIntents.create({
            amount, // Amount in cents (e.g., $50 = 5000)
            currency: "usd",
        });

        res.json({ clientSecret: paymentIntent.client_secret });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));