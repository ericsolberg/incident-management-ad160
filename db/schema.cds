using { API_BUSINESS_PARTNER_CC7 } from '../srv/external/API_BUSINESS_PARTNER_CC7';
using { cuid, managed } from '@sap/cds/common';

namespace sap.capire.incidents;

entity Incidents : cuid, managed {
  title            : String(100);
  urgency          : Association to UrgencyCodeList;
  status           : Association to StatusCodeList;
  customer         : Association to API_BUSINESS_PARTNER_CC7.A_BusinessPartner;
  messages         : Composition of many {
    key ID         : UUID;
    timestamp      : DateTime;
    author         : String(100);
    text           : String(1000);
  };
  createdAt        : DateTime @cds.on.insert : $now;
}

entity UrgencyCodeList {
  key code : String enum {
    high   = 'H';
    medium = 'M';
    low    = 'L';
  };
  name : String;
  criticality : Integer;
}

entity StatusCodeList {
  key code : String enum {
    new        = 'N';
    assigned   = 'A';
    in_process = 'I';
    on_hold    = 'H';
    resolved   = 'R';
    closed     = 'C';
  };
  name : String;
}

@cds.persistence.skip
extend API_BUSINESS_PARTNER_CC7.A_BusinessPartner with {
  incidents : Association to many Incidents on incidents.customer = $self;
}
