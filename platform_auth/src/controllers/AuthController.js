import bcrypt from 'bcryptjs';
import pool from '../db/db.js';
import { asyncHandler } from '../utils/asyncHandler.js';

class AuthController {
    /**
     * User Registration
     */
    register = asyncHandler(async (req, res) => {
        const { email, password } = req.body;

        if (!email || !password) {
            const error = new Error('Email and password are required');
            error.status = 400;
            throw error;
        }

        const passwordHash = await bcrypt.hash(password, 10);

        const result = await pool.query(
            'INSERT INTO users (email, password_hash) VALUES ($1, $2) RETURNING id, email, role, created_at',
            [email, passwordHash]
        );

        if (result.rows.length === 0) {
            const error = new Error('User registration failed');
            error.status = 500;
            throw error;
        }

        res.status(201).json({
            message: 'Registration successful',
            user: result.rows[0],
        });
    });

    /**
     * User Login
     */
    login = asyncHandler(async (req, res) => {
        const { email, password } = req.body;

        if (!email || !password) {
            const error = new Error('Email and password are required');
            error.status = 400;
            throw error;
        }

        const result = await pool.query(
            'SELECT id, email, password_hash, role FROM users WHERE email = $1',
            [email]
        );

        const user = result.rows[0];

        if (!user || !(await bcrypt.compare(password, user.password_hash))) {
            const error = new Error('Invalid email or password');
            error.status = 401;
            throw error;
        }

        res.json({
            message: 'Login successful',
            user: {
                id: user.id,
                email: user.email,
                role: user.role,
            },
        });
    });
}

export default new AuthController();
