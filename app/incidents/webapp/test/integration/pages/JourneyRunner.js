sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"incidentmanagement/incidents/test/integration/pages/IncidentsList",
	"incidentmanagement/incidents/test/integration/pages/IncidentsObjectPage"
], function (JourneyRunner, IncidentsList, IncidentsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('incidentmanagement/incidents') + '/test/flpSandbox.html#incidentmanagementincidents-tile',
        pages: {
			onTheIncidentsList: IncidentsList,
			onTheIncidentsObjectPage: IncidentsObjectPage
        },
        async: true
    });

    return runner;
});

