require('dotenv').config(); // Load environment variables
const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

const consumerKey = 'cUbPlIopSioFUYj81BlvbzSK1ph74Od6';
const consumerSecret = 'G2pvCIFPmZ36rk9rBkv5cCAnvmk=';

// Encode credentials in Base64 for authentication
const credentials = `${consumerKey}:${consumerSecret}`;
const base64Credentials = Buffer.from(credentials).toString('base64');

// 🛠️ Test Route (GET)
app.get('/api/payment', (req, res) => {
    res.send('API is working! Use a POST request for payments.');
});

// 🚀 Payment Route (POST)
app.post('/api/payment', async (req, res) => {
    try {
        const { amount, currency, userId } = req.body;

        // Payment data payload
        const paymentData = {
            amount: amount,
            currency: currency,
            description: "Test Payment",
            userId: userId,
        };

        // Request to Pesapal API
        const response = await axios.post(
            'https://cybqa.pesapal.com/pesapalv3/api/PostPayment', // Use sandbox URL for testing
            paymentData,
            {
                headers: {
                    'Authorization': `Basic ${base64Credentials}`, // Use Basic Auth, not Bearer
                    'Content-Type': 'application/json',
                },
            }
        );

        console.log('Pesapal Response:', response.data);
        res.json({ paymentUrl: response.data.paymentUrl });
    } catch (error) {
        console.error('Pesapal Error:', error.response ? error.response.data : error.message);
        res.status(500).json({ message: 'Payment initiation failed.', error: error.message });
    }
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
