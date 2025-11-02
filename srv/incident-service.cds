using { sap.capire.incidents as my } from '../db/schema';
using { API_BUSINESS_PARTNER_CC7 } from './external/API_BUSINESS_PARTNER_CC7';

service IncidentService @(path: '/incident') {
    entity Incidents as projection on my.Incidents;
    entity Customers as projection on API_BUSINESS_PARTNER_CC7.A_BusinessPartner {
        key BusinessPartner as ID,
        BusinessPartnerFullName as fullName,
        BusinessPartnerIsBlocked as isBlocked,
        *
    } excluding {
        BusinessPartnerUUID
    };

    @readonly
    entity UrgencyCodeList as projection on my.UrgencyCodeList;

    @readonly
    entity StatusCodeList as projection on my.StatusCodeList;
}

annotate IncidentService.Incidents with @odata.draft.enabled;

annotate IncidentService.Incidents with {
    ID          @title: 'Incident ID';
    title       @title: 'Title';
    urgency     @title: 'Urgency';
    status      @title: 'Status';
    customer    @title: 'Customer';
}

annotate IncidentService.Incidents with @(
    UI: {
        HeaderInfo: {
            TypeName: 'Incident',
            TypeNamePlural: 'Incidents',
            Title: {Value: title},
            Description: {Value: customer.BusinessPartnerFullName}
        },
        SelectionFields: [urgency, status, customer_ID],
        LineItem: [
            {Value: title},
            {Value: customer.BusinessPartnerFullName, Label: 'Customer'},
            {Value: urgency_code},
            {Value: status_code}
        ],
        Facets: [
            {$Type: 'UI.ReferenceFacet', Label: 'Main', Target: '@UI.FieldGroup#Main'},
            {$Type: 'UI.ReferenceFacet', Label: 'Messages', Target: 'messages/@UI.LineItem'}
        ],
        FieldGroup#Main: {
            Data: [
                {Value: title},
                {Value: customer_ID},
                {Value: urgency_code},
                {Value: status_code}
            ]
        }
    }
);

annotate IncidentService.Incidents.messages with @(UI: {
    LineItem: [
        {Value: author},
        {Value: timestamp},
        {Value: text}
    ]
});
