require('dotenv').config();
const express = require('express');
const stripe = require('stripe')('sk_test_51QcroNERybcrOMLTzWelRRiZCeKWPQ2byABmWINzipwporCNG33x31EPsttcQswZ3jWtio0c8bus8vYX4I7FbLfT00u39zl2Da');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

app.post('/create-checkout-session', async (req, res) => {
    try {
        const session = await stripe.checkout.sessions.create({
            payment_method_types: ['card'],
            line_items: [
                {
                    price_data: {
                        currency: 'usd',
                        product_data: { name: req.body.productName || 'Safari Chat' },
                        unit_amount: req.body.amount * 100, // Amount in cents
                    },
                    quantity: req.body.quantity || 1,
                },
            ],
            mode: 'payment',
            success_url: `${process.env.FRONTEND_URL}/success`,
            cancel_url: `${process.env.FRONTEND_URL}/cancel`,
        });

        res.json({ url: session.url });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));