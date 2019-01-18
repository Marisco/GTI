const dbConn = require('mysql');

class dbContext {

    constructor() {

        this.client = dbConn.createPool({
            host: 'robb0239.publiccloud.com.br',
            port: 3306,
            user: 'souza_u_gti_d',
            password: 'gti@S3s4!',
            database: 'souzaninja1_gti_sesa_desenv',
            timezone:'utc'
        });

        this.client.getConnection(function (err) {
            if (err) {
                return console.error('Connect error', err);
            }

            console.log('Conectado com souzaninja1_gti_sesa_desenv.')
        })

        this.client.on('error', function (err) {
            console.log('db error', err);
        })

    }

}

module.exports = {
    dbContext
};