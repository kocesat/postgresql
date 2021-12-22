const request = require('supertest');
const buildApp = require('../../app');
const UserRepo = require('../../repos/user-repo');
const pool = require('../../pool');
const Context = require('../context');

let context;

// Make a db connection for test
beforeAll(async () => {
    context = await Context.build();
});

// Close the connection
afterAll(() => {
    return pool.close();
});

it('create a user', async () => {
    const startingCount = await UserRepo.count();
    // expect(startingCount).toEqual(0)|

    await request(buildApp())
        .post('/users')
        .send({username: 'testuser', bio: 'test bio'})
        .expect(200);

    const finishCount = await UserRepo.count();
    expect(finishCount - startingCount).toEqual(1);
});


