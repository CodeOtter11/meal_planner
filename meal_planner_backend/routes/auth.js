const express = require('express');
const router = express.Router();
const User = require('../models/User');

// Signup
router.post('/signup', async (req, res) => {
  const { firstName, lastName, email, password } = req.body;
  try {
    const existingUser = await User.findOne({ email });
    if (existingUser) return res.status(400).json({ message: 'Email already exists' });

    const user = new User({ firstName, lastName, email, password });
    await user.save();
    res.json({ message: 'Signup successful', user });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Login
router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.findOne({ email, password });
    if (!user) return res.status(400).json({ message: 'Invalid credentials' });
    res.json({ message: 'Login successful', user });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
