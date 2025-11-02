using IncidentService as service from '../../srv/incident-service';

// Add UI.LineItem annotation to control the List Report columns
annotate service.Incidents with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.name,
            Criticality : urgency.criticality,
            Label : 'Urgency',
        },
        {
            $Type : 'UI.DataField',
            Value : status.name,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataField',
            Value : customer_BusinessPartner,
            Label : 'Customer',
        },
    ]
);

annotate service.Incidents with {
    urgency @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'UrgencyCodeList',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : urgency_code,
                ValueListProperty : 'code',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'criticality',
            },
        ],
    };
    urgency @Common.FieldControl: #Mandatory;
};

annotate service.Incidents with {
    status @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'StatusCodeList',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : status_code,
                ValueListProperty : 'code',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
        ],
    }
};