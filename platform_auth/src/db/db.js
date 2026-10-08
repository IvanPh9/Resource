import pg from 'pg';

const { Pool } = pg;

const pool = new Pool({
    connectionString: process.env.DATABASE_URL || undefined,
    host: process.env.DB_HOST || 'db',
    port: Number(process.env.DB_PORT) || 5432,
    user: process.env.DB_USER || process.env.DB_APP_USER || 'app_user',
    password: process.env.DB_PASSWORD || process.env.DB_APP_USER_PASSWORD,
    database: process.env.DB_NAME || process.env.POSTGRES_DB || 'auth_db',
    max: 20
});

export default pool;