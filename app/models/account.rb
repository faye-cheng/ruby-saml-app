class Account < ActiveRecord::Base
  def self.get_saml_settings(url_base)
    # this is just for testing purposes.
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    settings = OneLogin::RubySaml::Settings.new

    url_base ||= "http://localhost:3000"

    # Example settings data, replace this values!

    # When disabled, saml validation errors will raise an exception.
    settings.soft = true

    #SP section
    # settings.issuer                         = url_base + "/saml/metadata"
    # settings.issuer                         = "http://www.okta.com/exk2ontdkNR9MbnLE356"
    settings.issuer                         = ""
    settings.assertion_consumer_service_url = url_base + "/saml/acs"
    settings.assertion_consumer_logout_service_url = url_base + "/saml/logout"

    onelogin_app_id = "849820"

    # IdP section
    settings.idp_entity_id                  = "https://app.onelogin.com/saml/metadata/ea6faf15-eed6-45b4-af07-a09d5d94ff20"
    # settings.idp_entity_id                  = "https://app.onelogin.com/saml/metadata/#{onelogin_app_id}"
    settings.idp_sso_target_url             = "https://app.onelogin.com/trust/saml2/http-redirect/sso/#{onelogin_app_id}"
    settings.idp_slo_target_url             = "https://app.onelogin.com/trust/saml2/http-redirect/slo/#{onelogin_app_id}"
    settings.idp_cert                       = "-----BEGIN CERTIFICATE-----
    MIID2DCCAsCgAwIBAgIUU+2+EwYOMv0Uppx3+BtFwvfiBjswDQYJKoZIhvcNAQEF
    BQAwRDEPMA0GA1UECgwGQ2hlY2tyMRUwEwYDVQQLDAxPbmVMb2dpbiBJZFAxGjAY
    BgNVBAMMEU9uZUxvZ2luIEFjY291bnQgMB4XDTE4MTAxNjIxMzk1MloXDTIzMTAx
    NjIxMzk1MlowRDEPMA0GA1UECgwGQ2hlY2tyMRUwEwYDVQQLDAxPbmVMb2dpbiBJ
    ZFAxGjAYBgNVBAMMEU9uZUxvZ2luIEFjY291bnQgMIIBIjANBgkqhkiG9w0BAQEF
    AAOCAQ8AMIIBCgKCAQEA3fan/8njTr2AqupeMhRaV7yaTN37grj5jGUh4n8P6ZSX
    SeWZ/i6eAPhjShYR/PlJ39UAeOnG3/SzFZ75ABDCyzo3FlhfrPSckx5E1X5vSMar
    Rdop6/RW5JfNUrElzQFX8ZAeP1Xv0FAQZ3NmdsxnI7I8ssO6/t5MwFoOd0yBECfL
    Io6HQQNpvWMuMpR/Hth9bY8U8gG2yFX6AEk12Jj7T4EVUEayORVfC5G+vGhELaxa
    mZlGTIuRYZJkmPE5/hBgGJoc07OpCeW/H1DJIwAD8GuCy08zfdJn2Oj0YL8C7oue
    dIz2j8BPDA8SOw6Dkc5jsXcu+VsE7gTd/rO/Sj1N+wIDAQABo4HBMIG+MAwGA1Ud
    EwEB/wQCMAAwHQYDVR0OBBYEFLvxtbGF6aNvqHLXOUjncwe74/USMH8GA1UdIwR4
    MHaAFLvxtbGF6aNvqHLXOUjncwe74/USoUikRjBEMQ8wDQYDVQQKDAZDaGVja3Ix
    FTATBgNVBAsMDE9uZUxvZ2luIElkUDEaMBgGA1UEAwwRT25lTG9naW4gQWNjb3Vu
    dCCCFFPtvhMGDjL9FKacd/gbRcL34gY7MA4GA1UdDwEB/wQEAwIHgDANBgkqhkiG
    9w0BAQUFAAOCAQEAyuHhldT4waJfAvBBh10GYO+F5jDcKJ/wFH+ntP1Cfi7Q0L9I
    iZPPK7XNRnrnFHpCI5dnZvY5YNc9OcG/T9sY1Oe91pKItGGm1mNTt2hJwxRyINkJ
    vzS5bwNVqi7Np+wewM4ZJzv84qipChac2aMTOEQDMq0GNjBl+imazoU0pRf7I3HA
    EX2Hzk9UMwVTHB8so239D8bnFO2uneVbPOR6OjYjIAlpdkDKcjTchdNvhEgEbiIv
    3tjxGB5miu5OzXpuLcE9MWnHaGo1QwmP+VqS32a0xXtQFM7IlZbDlvY1BH3ICKG8
    78pJCV2RdPeDB1zlBAJrr8iJJUKQrddu6oljrQ==
    -----END CERTIFICATE-----
    "


    # or settings.idp_cert_fingerprint           = ""
    #    settings.idp_cert_fingerprint_algorithm = XMLSecurity::Document::SHA1

    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    # Security section
    settings.security[:authn_requests_signed] = false
    settings.security[:logout_requests_signed] = false
    settings.security[:logout_responses_signed] = false
    settings.security[:metadata_signed] = false
    settings.security[:digest_method] = XMLSecurity::Document::SHA1
    settings.security[:signature_method] = XMLSecurity::Document::RSA_SHA1

    settings
  end
end
