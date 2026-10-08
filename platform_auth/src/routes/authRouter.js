import { Router } from 'express';

const router = Router();

router.get('/login', (req, res) => {
  // Handle login logic here
  res.json({ message: 'Login successful' });
});
export default router;