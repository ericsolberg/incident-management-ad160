const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() {
    const { Incidents } = this.entities;

    this.before('UPDATE', 'Incidents', async (req) => {
        const incident = await SELECT.one.from(Incidents).where({ ID: req.data.ID });
        
        if (incident && incident.status_code === 'C') {
            req.error(400, 'Cannot modify a closed incident');
        }
        
        if (req.data.title && req.data.title.toLowerCase().includes('urgent')) {
            req.data.urgency_code = 'H';
        }
    });

    this.before('CREATE', 'Incidents', async (req) => {
        if (req.data.title && req.data.title.toLowerCase().includes('urgent')) {
            req.data.urgency_code = 'H';
        }
    });
});
