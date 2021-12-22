const pg = require('pg');

const pool = new pg.Pool({
    host: 'localhost',
    port: 5432,
    database: 'socialnetwork',
    user: 'postgres',
    password: 'Pass1234'
});

pool.query(`
    UPDATE posts
    SET loc = POINT(lng, lat)
    WHERE loc IS NULL;
`).then(() => {
    console.log('update complete');
    pool.end();
}).catch((err) => {
    console.log(err);
});