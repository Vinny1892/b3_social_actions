--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO root;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO root;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO root;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO root;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO root;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO root;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO root;

--
-- Name: client; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO root;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO root;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO root;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO root;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO root;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO root;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO root;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO root;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO root;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO root;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO root;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO root;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO root;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO root;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO root;

--
-- Name: component; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO root;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO root;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO root;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO root;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO root;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO root;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO root;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO root;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO root;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO root;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO root;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO root;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO root;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO root;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO root;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO root;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO root;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO root;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO root;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO root;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO root;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO root;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO root;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO root;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO root;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO root;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO root;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO root;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO root;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO root;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO root;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO root;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO root;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO root;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO root;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO root;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO root;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO root;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO root;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO root;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO root;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO root;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO root;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO root;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO root;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO root;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO root;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO root;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO root;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO root;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO root;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO root;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO root;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO root;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO root;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO root;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO root;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO root;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO root;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO root;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO root;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO root;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO root;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO root;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO root;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO root;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO root;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO root;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO root;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO root;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
f4710cce-77a7-4ca9-bbea-6dfdefb76c3b	\N	auth-cookie	33b59376-8366-4d43-a008-09a699620c97	659777c4-82cb-4878-be28-fb0491bba93b	2	10	f	\N	\N
4d52e221-649b-42ba-bbc6-49359a3b2cf3	\N	auth-spnego	33b59376-8366-4d43-a008-09a699620c97	659777c4-82cb-4878-be28-fb0491bba93b	3	20	f	\N	\N
9591c1dd-9737-4089-8de5-2b6b4879870e	\N	identity-provider-redirector	33b59376-8366-4d43-a008-09a699620c97	659777c4-82cb-4878-be28-fb0491bba93b	2	25	f	\N	\N
3cda5464-d7e7-44a4-aa0b-a4f1b6f14538	\N	\N	33b59376-8366-4d43-a008-09a699620c97	659777c4-82cb-4878-be28-fb0491bba93b	2	30	t	f9dd8aff-22d4-4217-adda-c861b11259da	\N
4ff7d652-22ed-4cdf-a04a-f826c769a702	\N	auth-username-password-form	33b59376-8366-4d43-a008-09a699620c97	f9dd8aff-22d4-4217-adda-c861b11259da	0	10	f	\N	\N
4e06595e-0173-48ee-ae40-f75bf4f642d1	\N	\N	33b59376-8366-4d43-a008-09a699620c97	f9dd8aff-22d4-4217-adda-c861b11259da	1	20	t	84d8abe2-a479-45c6-b66f-1223f461480d	\N
0880e1e2-1250-4aa8-b56e-759bf9ad8765	\N	conditional-user-configured	33b59376-8366-4d43-a008-09a699620c97	84d8abe2-a479-45c6-b66f-1223f461480d	0	10	f	\N	\N
5cdcb572-8472-4298-bc18-c044a63f02d0	\N	auth-otp-form	33b59376-8366-4d43-a008-09a699620c97	84d8abe2-a479-45c6-b66f-1223f461480d	0	20	f	\N	\N
31bd7f85-67d7-4f9e-8138-a99134077212	\N	direct-grant-validate-username	33b59376-8366-4d43-a008-09a699620c97	8726cd1f-425f-418a-a0f7-8e49f348f56d	0	10	f	\N	\N
f4c8e890-c049-493d-9247-78618104b356	\N	direct-grant-validate-password	33b59376-8366-4d43-a008-09a699620c97	8726cd1f-425f-418a-a0f7-8e49f348f56d	0	20	f	\N	\N
a5d4c3f9-a08c-4725-a476-a6593f014fe7	\N	\N	33b59376-8366-4d43-a008-09a699620c97	8726cd1f-425f-418a-a0f7-8e49f348f56d	1	30	t	89d5b4f4-29f4-4c98-8ea8-fc755bb383ac	\N
8194faf5-3705-4172-b3b8-195cf298762a	\N	conditional-user-configured	33b59376-8366-4d43-a008-09a699620c97	89d5b4f4-29f4-4c98-8ea8-fc755bb383ac	0	10	f	\N	\N
fca35f96-69ea-420f-9eaf-c40ca33d7fa4	\N	direct-grant-validate-otp	33b59376-8366-4d43-a008-09a699620c97	89d5b4f4-29f4-4c98-8ea8-fc755bb383ac	0	20	f	\N	\N
c369ed90-47de-4e2c-97b5-887a6963ff2c	\N	registration-page-form	33b59376-8366-4d43-a008-09a699620c97	9bfe34ac-50df-4270-8ed3-a0ae515180eb	0	10	t	95351c74-1461-48d7-b646-80c4ca28e6ea	\N
86737e46-40a8-4b71-8228-68f156faa5a3	\N	registration-user-creation	33b59376-8366-4d43-a008-09a699620c97	95351c74-1461-48d7-b646-80c4ca28e6ea	0	20	f	\N	\N
02e6dcd2-66bd-4673-a210-5dbeac143bff	\N	registration-profile-action	33b59376-8366-4d43-a008-09a699620c97	95351c74-1461-48d7-b646-80c4ca28e6ea	0	40	f	\N	\N
80f1bd22-230d-463f-bfa2-5e93ae2a7e6a	\N	registration-password-action	33b59376-8366-4d43-a008-09a699620c97	95351c74-1461-48d7-b646-80c4ca28e6ea	0	50	f	\N	\N
cc2174c9-2074-46a6-979c-71e8b4b9583e	\N	registration-recaptcha-action	33b59376-8366-4d43-a008-09a699620c97	95351c74-1461-48d7-b646-80c4ca28e6ea	3	60	f	\N	\N
e883b373-aa51-4b74-8fca-0cdc0337805e	\N	registration-terms-and-conditions	33b59376-8366-4d43-a008-09a699620c97	95351c74-1461-48d7-b646-80c4ca28e6ea	3	70	f	\N	\N
5a227c81-1652-490f-a98b-38d80d94e88e	\N	reset-credentials-choose-user	33b59376-8366-4d43-a008-09a699620c97	86c5f6f9-5fc5-407e-b8c1-8dc5e0e771bd	0	10	f	\N	\N
643aef5e-77f3-464b-84ec-c1cbdb5950af	\N	reset-credential-email	33b59376-8366-4d43-a008-09a699620c97	86c5f6f9-5fc5-407e-b8c1-8dc5e0e771bd	0	20	f	\N	\N
de436a65-9425-4a50-8492-78957999b422	\N	reset-password	33b59376-8366-4d43-a008-09a699620c97	86c5f6f9-5fc5-407e-b8c1-8dc5e0e771bd	0	30	f	\N	\N
c15995f7-9d6c-47ee-a968-3ec9b1899d7d	\N	\N	33b59376-8366-4d43-a008-09a699620c97	86c5f6f9-5fc5-407e-b8c1-8dc5e0e771bd	1	40	t	ca38a77d-0cdf-45c8-86f9-889d82a49053	\N
efbfe170-9d3e-4976-be40-ea8807bf2fa3	\N	conditional-user-configured	33b59376-8366-4d43-a008-09a699620c97	ca38a77d-0cdf-45c8-86f9-889d82a49053	0	10	f	\N	\N
8afd16c1-4bfd-4797-b12a-69c0e4b2395c	\N	reset-otp	33b59376-8366-4d43-a008-09a699620c97	ca38a77d-0cdf-45c8-86f9-889d82a49053	0	20	f	\N	\N
ff312280-2189-4886-aa66-1a92fc82e034	\N	client-secret	33b59376-8366-4d43-a008-09a699620c97	31ad81ae-d119-4f7b-b7a4-1145880284b6	2	10	f	\N	\N
d98da091-4a9e-4274-bd59-3ab15c57a5e7	\N	client-jwt	33b59376-8366-4d43-a008-09a699620c97	31ad81ae-d119-4f7b-b7a4-1145880284b6	2	20	f	\N	\N
128ce2c2-3325-4350-a060-aca91eb9887b	\N	client-secret-jwt	33b59376-8366-4d43-a008-09a699620c97	31ad81ae-d119-4f7b-b7a4-1145880284b6	2	30	f	\N	\N
f38dd908-c32b-47be-a8f5-545c2fb8993b	\N	client-x509	33b59376-8366-4d43-a008-09a699620c97	31ad81ae-d119-4f7b-b7a4-1145880284b6	2	40	f	\N	\N
00a5a74a-0323-4001-911c-856c2acc23c2	\N	idp-review-profile	33b59376-8366-4d43-a008-09a699620c97	e05714d7-5c9a-430f-89dd-73a44ecebbc7	0	10	f	\N	dfa76767-d081-4894-bfd6-f9ecc450d358
e8b715e4-c5f5-40d7-90aa-b9cb65dac13b	\N	\N	33b59376-8366-4d43-a008-09a699620c97	e05714d7-5c9a-430f-89dd-73a44ecebbc7	0	20	t	b46b960f-c980-4f77-80fa-6f573ca02485	\N
305ea07f-8431-4b05-8648-26b93eee0238	\N	idp-create-user-if-unique	33b59376-8366-4d43-a008-09a699620c97	b46b960f-c980-4f77-80fa-6f573ca02485	2	10	f	\N	8f0f73a5-13b9-4ca9-bdb3-a07b91b13994
a89b6520-b48a-4bdc-8227-a04c71c8dd29	\N	\N	33b59376-8366-4d43-a008-09a699620c97	b46b960f-c980-4f77-80fa-6f573ca02485	2	20	t	9235cf80-3d21-4c18-a8fc-21cebd93ae46	\N
2a485296-73e0-402b-a175-cbe86f4614be	\N	idp-confirm-link	33b59376-8366-4d43-a008-09a699620c97	9235cf80-3d21-4c18-a8fc-21cebd93ae46	0	10	f	\N	\N
7ceb07d5-43a8-45f1-933a-10e4b8d85956	\N	\N	33b59376-8366-4d43-a008-09a699620c97	9235cf80-3d21-4c18-a8fc-21cebd93ae46	0	20	t	e0fd00e0-d84f-41f3-b294-057f977b7736	\N
744ccdd3-b36c-477a-99f0-867061e905ee	\N	idp-email-verification	33b59376-8366-4d43-a008-09a699620c97	e0fd00e0-d84f-41f3-b294-057f977b7736	2	10	f	\N	\N
e6c7c805-8743-40b9-bc9c-1583f58b9ed7	\N	\N	33b59376-8366-4d43-a008-09a699620c97	e0fd00e0-d84f-41f3-b294-057f977b7736	2	20	t	b937346b-1965-4ec6-b767-8da225400764	\N
4270658e-ddb3-40c6-b511-e89c59a681f6	\N	idp-username-password-form	33b59376-8366-4d43-a008-09a699620c97	b937346b-1965-4ec6-b767-8da225400764	0	10	f	\N	\N
d7693837-1f9f-46b8-8c59-8129f104f48b	\N	\N	33b59376-8366-4d43-a008-09a699620c97	b937346b-1965-4ec6-b767-8da225400764	1	20	t	0aa8e9e3-fadb-47bc-a7c4-a3b9ca20b7c0	\N
f939327e-eed0-49b8-bdb1-e8484ac93e2e	\N	conditional-user-configured	33b59376-8366-4d43-a008-09a699620c97	0aa8e9e3-fadb-47bc-a7c4-a3b9ca20b7c0	0	10	f	\N	\N
14c56a98-8748-4f87-b379-8049aca27b0c	\N	auth-otp-form	33b59376-8366-4d43-a008-09a699620c97	0aa8e9e3-fadb-47bc-a7c4-a3b9ca20b7c0	0	20	f	\N	\N
5e6a66c3-e434-47ad-a10a-efb7e8ed9f57	\N	http-basic-authenticator	33b59376-8366-4d43-a008-09a699620c97	6682cf13-1c0d-4778-9b60-cf5a9702833f	0	10	f	\N	\N
ef56e2bd-a694-41f9-b55c-53c43d8456eb	\N	docker-http-basic-authenticator	33b59376-8366-4d43-a008-09a699620c97	d601f4d9-4508-41e8-ac39-ef4eca1422ea	0	10	f	\N	\N
85e8f853-c478-4d91-92d8-ade6e854c0f2	\N	auth-cookie	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ad0a5703-5c3f-4c8a-a46b-cfc7e8b9ca0f	2	10	f	\N	\N
de83b6b3-34b8-422f-a482-41e779da06d1	\N	auth-spnego	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ad0a5703-5c3f-4c8a-a46b-cfc7e8b9ca0f	3	20	f	\N	\N
286a08b5-4433-4350-9408-3b2c006cc12c	\N	identity-provider-redirector	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ad0a5703-5c3f-4c8a-a46b-cfc7e8b9ca0f	2	25	f	\N	\N
7503bd89-c793-4861-919d-a9d9bfd4096a	\N	\N	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ad0a5703-5c3f-4c8a-a46b-cfc7e8b9ca0f	2	30	t	0e68b570-4d75-424b-8f58-dcb75d73388f	\N
1e43e3d2-9b1f-4308-8b73-68b05c0ce957	\N	auth-username-password-form	c17fc45e-3905-44c8-b28e-8ee1efd0c910	0e68b570-4d75-424b-8f58-dcb75d73388f	0	10	f	\N	\N
69768b0c-e9f2-45b0-9ca2-92c0f479a3b2	\N	\N	c17fc45e-3905-44c8-b28e-8ee1efd0c910	0e68b570-4d75-424b-8f58-dcb75d73388f	1	20	t	a1d1072a-7349-44b8-9dc3-8978fec9dde2	\N
0e99c072-e0bc-43e5-8e0d-a0dbe4fbe1b9	\N	conditional-user-configured	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a1d1072a-7349-44b8-9dc3-8978fec9dde2	0	10	f	\N	\N
24f3e7b0-10b4-46f1-993d-52740bce00a6	\N	auth-otp-form	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a1d1072a-7349-44b8-9dc3-8978fec9dde2	0	20	f	\N	\N
fb097f71-2ab7-4382-9d75-562ac198c922	\N	direct-grant-validate-username	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ba76f0bc-b114-4128-8d4b-af5b5a3664bc	0	10	f	\N	\N
23ea9953-dcb6-48e9-8a6a-7d82c98943cf	\N	direct-grant-validate-password	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ba76f0bc-b114-4128-8d4b-af5b5a3664bc	0	20	f	\N	\N
79be2fc7-d02f-4219-a141-867ad6500aa6	\N	\N	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ba76f0bc-b114-4128-8d4b-af5b5a3664bc	1	30	t	4de6f23a-eaca-47e6-b7f8-8d9b9678887d	\N
5885ac85-56e3-46e9-ac0c-c9099f3a7e8b	\N	conditional-user-configured	c17fc45e-3905-44c8-b28e-8ee1efd0c910	4de6f23a-eaca-47e6-b7f8-8d9b9678887d	0	10	f	\N	\N
f8d12c64-20d7-450c-8a92-f1dd7ffc5a6f	\N	direct-grant-validate-otp	c17fc45e-3905-44c8-b28e-8ee1efd0c910	4de6f23a-eaca-47e6-b7f8-8d9b9678887d	0	20	f	\N	\N
c950c912-645b-4b86-a0fc-cc36899bc974	\N	registration-page-form	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f48ef93c-d7e6-4e34-b056-a499da242bb8	0	10	t	f8175bf0-d5af-4562-bc97-dcf837f830bb	\N
1052b07c-ee86-426d-a8fb-cd0ba47452a2	\N	registration-user-creation	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f8175bf0-d5af-4562-bc97-dcf837f830bb	0	20	f	\N	\N
941455f5-4097-4574-82b8-6cc5b437ce4b	\N	registration-profile-action	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f8175bf0-d5af-4562-bc97-dcf837f830bb	0	40	f	\N	\N
32074502-80cf-4063-8565-04c61a9b94ee	\N	registration-password-action	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f8175bf0-d5af-4562-bc97-dcf837f830bb	0	50	f	\N	\N
a4679249-44ed-4cf4-91f7-c9979f94aab6	\N	registration-recaptcha-action	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f8175bf0-d5af-4562-bc97-dcf837f830bb	3	60	f	\N	\N
b8fe3913-6760-4b52-88ed-a0c92c3e8fe2	\N	reset-credentials-choose-user	c17fc45e-3905-44c8-b28e-8ee1efd0c910	2fda754d-45bf-41ea-a1bb-2b57c65dffd9	0	10	f	\N	\N
c251664d-0014-4fc0-add1-dd4f83bc0bc8	\N	reset-credential-email	c17fc45e-3905-44c8-b28e-8ee1efd0c910	2fda754d-45bf-41ea-a1bb-2b57c65dffd9	0	20	f	\N	\N
345c036b-7a61-4d16-9f06-62fb79f1b3bb	\N	reset-password	c17fc45e-3905-44c8-b28e-8ee1efd0c910	2fda754d-45bf-41ea-a1bb-2b57c65dffd9	0	30	f	\N	\N
65424ba9-57aa-4915-b55a-f73ad6043430	\N	\N	c17fc45e-3905-44c8-b28e-8ee1efd0c910	2fda754d-45bf-41ea-a1bb-2b57c65dffd9	1	40	t	a2358048-a85b-4f19-8545-bf6954caf6d6	\N
f24afd02-80f3-4e46-a8e5-4bed07c4e0e9	\N	conditional-user-configured	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a2358048-a85b-4f19-8545-bf6954caf6d6	0	10	f	\N	\N
9e4f52da-854b-4deb-90bf-c4c53c2931b0	\N	reset-otp	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a2358048-a85b-4f19-8545-bf6954caf6d6	0	20	f	\N	\N
dbaa9fd3-9293-4564-af80-d4deb012bd52	\N	client-secret	c17fc45e-3905-44c8-b28e-8ee1efd0c910	740c7149-abdf-4ea8-a19a-fd2a3e440af1	2	10	f	\N	\N
69d0e48e-9672-4e48-b945-1ac26dc50fab	\N	client-jwt	c17fc45e-3905-44c8-b28e-8ee1efd0c910	740c7149-abdf-4ea8-a19a-fd2a3e440af1	2	20	f	\N	\N
03a3fea8-4fcd-4ee4-8d35-4c5fa6dd8c8a	\N	client-secret-jwt	c17fc45e-3905-44c8-b28e-8ee1efd0c910	740c7149-abdf-4ea8-a19a-fd2a3e440af1	2	30	f	\N	\N
8ae259d8-b3e7-44cd-a180-a5e946fa42c2	\N	client-x509	c17fc45e-3905-44c8-b28e-8ee1efd0c910	740c7149-abdf-4ea8-a19a-fd2a3e440af1	2	40	f	\N	\N
e8aaf16d-b4ab-4642-bee0-4e0dd9558543	\N	idp-review-profile	c17fc45e-3905-44c8-b28e-8ee1efd0c910	b880e99c-38fa-4192-bdf9-57c6baae109d	0	10	f	\N	cee1edff-81b4-4833-bf21-24356ec70723
b2d5970f-2b81-4ce7-ba88-5b0dc063c16e	\N	\N	c17fc45e-3905-44c8-b28e-8ee1efd0c910	b880e99c-38fa-4192-bdf9-57c6baae109d	0	20	t	5a862c41-4392-44f3-9ec6-e2d64ad73e03	\N
c7ddcd17-5fd7-4e5a-bf09-eb1224b4cba1	\N	idp-create-user-if-unique	c17fc45e-3905-44c8-b28e-8ee1efd0c910	5a862c41-4392-44f3-9ec6-e2d64ad73e03	2	10	f	\N	16d3b234-7010-45e1-a82a-32bc052f6108
a95237fc-bbf0-4a10-8aae-aa257d554236	\N	\N	c17fc45e-3905-44c8-b28e-8ee1efd0c910	5a862c41-4392-44f3-9ec6-e2d64ad73e03	2	20	t	ff049847-8c0c-4938-9fa3-90c5e58f56b9	\N
91b67401-8614-4c06-be67-173ec23bda4b	\N	idp-confirm-link	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ff049847-8c0c-4938-9fa3-90c5e58f56b9	0	10	f	\N	\N
40c46fea-0fa7-4772-baba-c67446525eb3	\N	\N	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ff049847-8c0c-4938-9fa3-90c5e58f56b9	0	20	t	f5778bc3-c66a-4693-8222-027e92323ada	\N
25ad737a-913d-4ca2-aac8-d944c39da741	\N	idp-email-verification	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f5778bc3-c66a-4693-8222-027e92323ada	2	10	f	\N	\N
3031addf-a6be-432d-8670-ecc570e4ae04	\N	\N	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f5778bc3-c66a-4693-8222-027e92323ada	2	20	t	22eb9683-b535-4c7d-ac7a-12d88847d456	\N
658f3b5b-b95d-47f0-a18e-86a1881fdb46	\N	idp-username-password-form	c17fc45e-3905-44c8-b28e-8ee1efd0c910	22eb9683-b535-4c7d-ac7a-12d88847d456	0	10	f	\N	\N
8365ce09-5885-47dc-8ef4-30fc8157f6c6	\N	\N	c17fc45e-3905-44c8-b28e-8ee1efd0c910	22eb9683-b535-4c7d-ac7a-12d88847d456	1	20	t	4a0ebec7-26c0-4228-aaf3-82cec049022a	\N
4057b23d-b682-438e-a288-1ca2689077fc	\N	conditional-user-configured	c17fc45e-3905-44c8-b28e-8ee1efd0c910	4a0ebec7-26c0-4228-aaf3-82cec049022a	0	10	f	\N	\N
ea4011b5-48d3-4fa6-8339-6e0a56bf7887	\N	auth-otp-form	c17fc45e-3905-44c8-b28e-8ee1efd0c910	4a0ebec7-26c0-4228-aaf3-82cec049022a	0	20	f	\N	\N
1aa3b7eb-6ed7-4e6b-97de-6618cbe35a01	\N	http-basic-authenticator	c17fc45e-3905-44c8-b28e-8ee1efd0c910	84825b07-6555-45dc-9726-4d490932adf3	0	10	f	\N	\N
fc22f144-8b9a-42ba-bfde-6cda430e75b3	\N	docker-http-basic-authenticator	c17fc45e-3905-44c8-b28e-8ee1efd0c910	8e5fcb9b-71f4-4f53-ae66-ebbd0d2eb888	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
659777c4-82cb-4878-be28-fb0491bba93b	browser	browser based authentication	33b59376-8366-4d43-a008-09a699620c97	basic-flow	t	t
f9dd8aff-22d4-4217-adda-c861b11259da	forms	Username, password, otp and other auth forms.	33b59376-8366-4d43-a008-09a699620c97	basic-flow	f	t
84d8abe2-a479-45c6-b66f-1223f461480d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	33b59376-8366-4d43-a008-09a699620c97	basic-flow	f	t
8726cd1f-425f-418a-a0f7-8e49f348f56d	direct grant	OpenID Connect Resource Owner Grant	33b59376-8366-4d43-a008-09a699620c97	basic-flow	t	t
89d5b4f4-29f4-4c98-8ea8-fc755bb383ac	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	33b59376-8366-4d43-a008-09a699620c97	basic-flow	f	t
9bfe34ac-50df-4270-8ed3-a0ae515180eb	registration	registration flow	33b59376-8366-4d43-a008-09a699620c97	basic-flow	t	t
95351c74-1461-48d7-b646-80c4ca28e6ea	registration form	registration form	33b59376-8366-4d43-a008-09a699620c97	form-flow	f	t
86c5f6f9-5fc5-407e-b8c1-8dc5e0e771bd	reset credentials	Reset credentials for a user if they forgot their password or something	33b59376-8366-4d43-a008-09a699620c97	basic-flow	t	t
ca38a77d-0cdf-45c8-86f9-889d82a49053	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	33b59376-8366-4d43-a008-09a699620c97	basic-flow	f	t
31ad81ae-d119-4f7b-b7a4-1145880284b6	clients	Base authentication for clients	33b59376-8366-4d43-a008-09a699620c97	client-flow	t	t
e05714d7-5c9a-430f-89dd-73a44ecebbc7	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	33b59376-8366-4d43-a008-09a699620c97	basic-flow	t	t
b46b960f-c980-4f77-80fa-6f573ca02485	User creation or linking	Flow for the existing/non-existing user alternatives	33b59376-8366-4d43-a008-09a699620c97	basic-flow	f	t
9235cf80-3d21-4c18-a8fc-21cebd93ae46	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	33b59376-8366-4d43-a008-09a699620c97	basic-flow	f	t
e0fd00e0-d84f-41f3-b294-057f977b7736	Account verification options	Method with which to verity the existing account	33b59376-8366-4d43-a008-09a699620c97	basic-flow	f	t
b937346b-1965-4ec6-b767-8da225400764	Verify Existing Account by Re-authentication	Reauthentication of existing account	33b59376-8366-4d43-a008-09a699620c97	basic-flow	f	t
0aa8e9e3-fadb-47bc-a7c4-a3b9ca20b7c0	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	33b59376-8366-4d43-a008-09a699620c97	basic-flow	f	t
6682cf13-1c0d-4778-9b60-cf5a9702833f	saml ecp	SAML ECP Profile Authentication Flow	33b59376-8366-4d43-a008-09a699620c97	basic-flow	t	t
d601f4d9-4508-41e8-ac39-ef4eca1422ea	docker auth	Used by Docker clients to authenticate against the IDP	33b59376-8366-4d43-a008-09a699620c97	basic-flow	t	t
ad0a5703-5c3f-4c8a-a46b-cfc7e8b9ca0f	browser	browser based authentication	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	t	t
0e68b570-4d75-424b-8f58-dcb75d73388f	forms	Username, password, otp and other auth forms.	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	f	t
a1d1072a-7349-44b8-9dc3-8978fec9dde2	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	f	t
ba76f0bc-b114-4128-8d4b-af5b5a3664bc	direct grant	OpenID Connect Resource Owner Grant	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	t	t
4de6f23a-eaca-47e6-b7f8-8d9b9678887d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	f	t
f48ef93c-d7e6-4e34-b056-a499da242bb8	registration	registration flow	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	t	t
f8175bf0-d5af-4562-bc97-dcf837f830bb	registration form	registration form	c17fc45e-3905-44c8-b28e-8ee1efd0c910	form-flow	f	t
2fda754d-45bf-41ea-a1bb-2b57c65dffd9	reset credentials	Reset credentials for a user if they forgot their password or something	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	t	t
a2358048-a85b-4f19-8545-bf6954caf6d6	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	f	t
740c7149-abdf-4ea8-a19a-fd2a3e440af1	clients	Base authentication for clients	c17fc45e-3905-44c8-b28e-8ee1efd0c910	client-flow	t	t
b880e99c-38fa-4192-bdf9-57c6baae109d	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	t	t
5a862c41-4392-44f3-9ec6-e2d64ad73e03	User creation or linking	Flow for the existing/non-existing user alternatives	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	f	t
ff049847-8c0c-4938-9fa3-90c5e58f56b9	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	f	t
f5778bc3-c66a-4693-8222-027e92323ada	Account verification options	Method with which to verity the existing account	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	f	t
22eb9683-b535-4c7d-ac7a-12d88847d456	Verify Existing Account by Re-authentication	Reauthentication of existing account	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	f	t
4a0ebec7-26c0-4228-aaf3-82cec049022a	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	f	t
84825b07-6555-45dc-9726-4d490932adf3	saml ecp	SAML ECP Profile Authentication Flow	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	t	t
8e5fcb9b-71f4-4f53-ae66-ebbd0d2eb888	docker auth	Used by Docker clients to authenticate against the IDP	c17fc45e-3905-44c8-b28e-8ee1efd0c910	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
dfa76767-d081-4894-bfd6-f9ecc450d358	review profile config	33b59376-8366-4d43-a008-09a699620c97
8f0f73a5-13b9-4ca9-bdb3-a07b91b13994	create unique user config	33b59376-8366-4d43-a008-09a699620c97
cee1edff-81b4-4833-bf21-24356ec70723	review profile config	c17fc45e-3905-44c8-b28e-8ee1efd0c910
16d3b234-7010-45e1-a82a-32bc052f6108	create unique user config	c17fc45e-3905-44c8-b28e-8ee1efd0c910
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
8f0f73a5-13b9-4ca9-bdb3-a07b91b13994	false	require.password.update.after.registration
dfa76767-d081-4894-bfd6-f9ecc450d358	missing	update.profile.on.first.login
16d3b234-7010-45e1-a82a-32bc052f6108	false	require.password.update.after.registration
cee1edff-81b4-4833-bf21-24356ec70723	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
cff74c4b-1854-433b-b119-9374fd36bb06	t	f	master-realm	0	f	\N	\N	t	\N	f	33b59376-8366-4d43-a008-09a699620c97	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
be31244a-8352-4068-a494-0611b28f8a6d	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	33b59376-8366-4d43-a008-09a699620c97	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5a298aed-16ad-443c-97bc-7c0484fa2768	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	33b59376-8366-4d43-a008-09a699620c97	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	t	f	broker	0	f	\N	\N	t	\N	f	33b59376-8366-4d43-a008-09a699620c97	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	33b59376-8366-4d43-a008-09a699620c97	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
dd9ee04f-6761-4788-89de-259e46d16093	t	f	admin-cli	0	t	\N	\N	f	\N	f	33b59376-8366-4d43-a008-09a699620c97	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	f	b3_social-realm	0	f	\N	\N	t	\N	f	33b59376-8366-4d43-a008-09a699620c97	\N	0	f	f	b3_social Realm	f	client-secret	\N	\N	\N	t	f	f	f
e5f5434d-2580-4410-9492-120e2a618e7a	t	f	realm-management	0	f	\N	\N	t	\N	f	c17fc45e-3905-44c8-b28e-8ee1efd0c910	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	t	f	account	0	t	\N	/realms/b3_social/account/	f	\N	f	c17fc45e-3905-44c8-b28e-8ee1efd0c910	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2c734bda-b684-4c63-becb-d9c862a36bfb	t	f	account-console	0	t	\N	/realms/b3_social/account/	f	\N	f	c17fc45e-3905-44c8-b28e-8ee1efd0c910	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c65288d4-879f-40b7-a4f3-d46b7f61163d	t	f	broker	0	f	\N	\N	t	\N	f	c17fc45e-3905-44c8-b28e-8ee1efd0c910	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
39dc6190-8591-442b-ad84-94882ffbbf34	t	f	security-admin-console	0	t	\N	/admin/b3_social/console/	f	\N	f	c17fc45e-3905-44c8-b28e-8ee1efd0c910	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
1d561b35-f3aa-4e68-9f75-469ca082589c	t	f	admin-cli	0	t	\N	\N	f	\N	f	c17fc45e-3905-44c8-b28e-8ee1efd0c910	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
be31244a-8352-4068-a494-0611b28f8a6d	post.logout.redirect.uris	+
5a298aed-16ad-443c-97bc-7c0484fa2768	post.logout.redirect.uris	+
5a298aed-16ad-443c-97bc-7c0484fa2768	pkce.code.challenge.method	S256
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	post.logout.redirect.uris	+
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	pkce.code.challenge.method	S256
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	post.logout.redirect.uris	+
2c734bda-b684-4c63-becb-d9c862a36bfb	post.logout.redirect.uris	+
2c734bda-b684-4c63-becb-d9c862a36bfb	pkce.code.challenge.method	S256
39dc6190-8591-442b-ad84-94882ffbbf34	post.logout.redirect.uris	+
39dc6190-8591-442b-ad84-94882ffbbf34	pkce.code.challenge.method	S256
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
e1d14222-6662-4a3c-bfa0-2e862d00db2e	offline_access	33b59376-8366-4d43-a008-09a699620c97	OpenID Connect built-in scope: offline_access	openid-connect
cc763bc9-c56c-4638-adb5-44ee6d897432	role_list	33b59376-8366-4d43-a008-09a699620c97	SAML role list	saml
83f5c21e-585e-45bf-94d0-d8f513e31122	profile	33b59376-8366-4d43-a008-09a699620c97	OpenID Connect built-in scope: profile	openid-connect
f870b6d8-8187-44d4-8bc1-5de67f29d0b8	email	33b59376-8366-4d43-a008-09a699620c97	OpenID Connect built-in scope: email	openid-connect
65b16678-cdfb-4d44-9b78-d1e4cbbb9515	address	33b59376-8366-4d43-a008-09a699620c97	OpenID Connect built-in scope: address	openid-connect
a1a10d1b-c744-404c-b9fc-2566681a1116	phone	33b59376-8366-4d43-a008-09a699620c97	OpenID Connect built-in scope: phone	openid-connect
1be887c1-ee09-4978-aa94-8bdd6164c375	roles	33b59376-8366-4d43-a008-09a699620c97	OpenID Connect scope for add user roles to the access token	openid-connect
9fe5369b-e588-4213-ab80-1081f7a7b767	web-origins	33b59376-8366-4d43-a008-09a699620c97	OpenID Connect scope for add allowed web origins to the access token	openid-connect
e2c02738-5d71-4d05-af36-bbc5df14b924	microprofile-jwt	33b59376-8366-4d43-a008-09a699620c97	Microprofile - JWT built-in scope	openid-connect
3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	acr	33b59376-8366-4d43-a008-09a699620c97	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
d1ec51c5-66b9-41a2-a829-082f1072d896	offline_access	c17fc45e-3905-44c8-b28e-8ee1efd0c910	OpenID Connect built-in scope: offline_access	openid-connect
3d5ba115-b7b3-4c9f-8a9f-4f6dc66d411c	role_list	c17fc45e-3905-44c8-b28e-8ee1efd0c910	SAML role list	saml
96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	profile	c17fc45e-3905-44c8-b28e-8ee1efd0c910	OpenID Connect built-in scope: profile	openid-connect
162c8fc8-a01b-470d-97ad-c37d33b0db02	email	c17fc45e-3905-44c8-b28e-8ee1efd0c910	OpenID Connect built-in scope: email	openid-connect
f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	address	c17fc45e-3905-44c8-b28e-8ee1efd0c910	OpenID Connect built-in scope: address	openid-connect
3d8869f0-c392-442b-9538-3da055b888d6	phone	c17fc45e-3905-44c8-b28e-8ee1efd0c910	OpenID Connect built-in scope: phone	openid-connect
ffc69274-6a58-46e9-89ca-dc90c48571ae	roles	c17fc45e-3905-44c8-b28e-8ee1efd0c910	OpenID Connect scope for add user roles to the access token	openid-connect
33cea8d0-b96b-4546-9703-41835e684bee	web-origins	c17fc45e-3905-44c8-b28e-8ee1efd0c910	OpenID Connect scope for add allowed web origins to the access token	openid-connect
7ddf47d7-ba36-4f1f-b972-70999ceb66a8	microprofile-jwt	c17fc45e-3905-44c8-b28e-8ee1efd0c910	Microprofile - JWT built-in scope	openid-connect
7fa7e989-2079-40f9-bc88-cc47d25ae231	acr	c17fc45e-3905-44c8-b28e-8ee1efd0c910	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
e1d14222-6662-4a3c-bfa0-2e862d00db2e	true	display.on.consent.screen
e1d14222-6662-4a3c-bfa0-2e862d00db2e	${offlineAccessScopeConsentText}	consent.screen.text
cc763bc9-c56c-4638-adb5-44ee6d897432	true	display.on.consent.screen
cc763bc9-c56c-4638-adb5-44ee6d897432	${samlRoleListScopeConsentText}	consent.screen.text
83f5c21e-585e-45bf-94d0-d8f513e31122	true	display.on.consent.screen
83f5c21e-585e-45bf-94d0-d8f513e31122	${profileScopeConsentText}	consent.screen.text
83f5c21e-585e-45bf-94d0-d8f513e31122	true	include.in.token.scope
f870b6d8-8187-44d4-8bc1-5de67f29d0b8	true	display.on.consent.screen
f870b6d8-8187-44d4-8bc1-5de67f29d0b8	${emailScopeConsentText}	consent.screen.text
f870b6d8-8187-44d4-8bc1-5de67f29d0b8	true	include.in.token.scope
65b16678-cdfb-4d44-9b78-d1e4cbbb9515	true	display.on.consent.screen
65b16678-cdfb-4d44-9b78-d1e4cbbb9515	${addressScopeConsentText}	consent.screen.text
65b16678-cdfb-4d44-9b78-d1e4cbbb9515	true	include.in.token.scope
a1a10d1b-c744-404c-b9fc-2566681a1116	true	display.on.consent.screen
a1a10d1b-c744-404c-b9fc-2566681a1116	${phoneScopeConsentText}	consent.screen.text
a1a10d1b-c744-404c-b9fc-2566681a1116	true	include.in.token.scope
1be887c1-ee09-4978-aa94-8bdd6164c375	true	display.on.consent.screen
1be887c1-ee09-4978-aa94-8bdd6164c375	${rolesScopeConsentText}	consent.screen.text
1be887c1-ee09-4978-aa94-8bdd6164c375	false	include.in.token.scope
9fe5369b-e588-4213-ab80-1081f7a7b767	false	display.on.consent.screen
9fe5369b-e588-4213-ab80-1081f7a7b767		consent.screen.text
9fe5369b-e588-4213-ab80-1081f7a7b767	false	include.in.token.scope
e2c02738-5d71-4d05-af36-bbc5df14b924	false	display.on.consent.screen
e2c02738-5d71-4d05-af36-bbc5df14b924	true	include.in.token.scope
3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	false	display.on.consent.screen
3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	false	include.in.token.scope
d1ec51c5-66b9-41a2-a829-082f1072d896	true	display.on.consent.screen
d1ec51c5-66b9-41a2-a829-082f1072d896	${offlineAccessScopeConsentText}	consent.screen.text
3d5ba115-b7b3-4c9f-8a9f-4f6dc66d411c	true	display.on.consent.screen
3d5ba115-b7b3-4c9f-8a9f-4f6dc66d411c	${samlRoleListScopeConsentText}	consent.screen.text
96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	true	display.on.consent.screen
96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	${profileScopeConsentText}	consent.screen.text
96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	true	include.in.token.scope
162c8fc8-a01b-470d-97ad-c37d33b0db02	true	display.on.consent.screen
162c8fc8-a01b-470d-97ad-c37d33b0db02	${emailScopeConsentText}	consent.screen.text
162c8fc8-a01b-470d-97ad-c37d33b0db02	true	include.in.token.scope
f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	true	display.on.consent.screen
f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	${addressScopeConsentText}	consent.screen.text
f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	true	include.in.token.scope
3d8869f0-c392-442b-9538-3da055b888d6	true	display.on.consent.screen
3d8869f0-c392-442b-9538-3da055b888d6	${phoneScopeConsentText}	consent.screen.text
3d8869f0-c392-442b-9538-3da055b888d6	true	include.in.token.scope
ffc69274-6a58-46e9-89ca-dc90c48571ae	true	display.on.consent.screen
ffc69274-6a58-46e9-89ca-dc90c48571ae	${rolesScopeConsentText}	consent.screen.text
ffc69274-6a58-46e9-89ca-dc90c48571ae	false	include.in.token.scope
33cea8d0-b96b-4546-9703-41835e684bee	false	display.on.consent.screen
33cea8d0-b96b-4546-9703-41835e684bee		consent.screen.text
33cea8d0-b96b-4546-9703-41835e684bee	false	include.in.token.scope
7ddf47d7-ba36-4f1f-b972-70999ceb66a8	false	display.on.consent.screen
7ddf47d7-ba36-4f1f-b972-70999ceb66a8	true	include.in.token.scope
7fa7e989-2079-40f9-bc88-cc47d25ae231	false	display.on.consent.screen
7fa7e989-2079-40f9-bc88-cc47d25ae231	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
be31244a-8352-4068-a494-0611b28f8a6d	1be887c1-ee09-4978-aa94-8bdd6164c375	t
be31244a-8352-4068-a494-0611b28f8a6d	f870b6d8-8187-44d4-8bc1-5de67f29d0b8	t
be31244a-8352-4068-a494-0611b28f8a6d	3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	t
be31244a-8352-4068-a494-0611b28f8a6d	9fe5369b-e588-4213-ab80-1081f7a7b767	t
be31244a-8352-4068-a494-0611b28f8a6d	83f5c21e-585e-45bf-94d0-d8f513e31122	t
be31244a-8352-4068-a494-0611b28f8a6d	e2c02738-5d71-4d05-af36-bbc5df14b924	f
be31244a-8352-4068-a494-0611b28f8a6d	e1d14222-6662-4a3c-bfa0-2e862d00db2e	f
be31244a-8352-4068-a494-0611b28f8a6d	65b16678-cdfb-4d44-9b78-d1e4cbbb9515	f
be31244a-8352-4068-a494-0611b28f8a6d	a1a10d1b-c744-404c-b9fc-2566681a1116	f
5a298aed-16ad-443c-97bc-7c0484fa2768	1be887c1-ee09-4978-aa94-8bdd6164c375	t
5a298aed-16ad-443c-97bc-7c0484fa2768	f870b6d8-8187-44d4-8bc1-5de67f29d0b8	t
5a298aed-16ad-443c-97bc-7c0484fa2768	3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	t
5a298aed-16ad-443c-97bc-7c0484fa2768	9fe5369b-e588-4213-ab80-1081f7a7b767	t
5a298aed-16ad-443c-97bc-7c0484fa2768	83f5c21e-585e-45bf-94d0-d8f513e31122	t
5a298aed-16ad-443c-97bc-7c0484fa2768	e2c02738-5d71-4d05-af36-bbc5df14b924	f
5a298aed-16ad-443c-97bc-7c0484fa2768	e1d14222-6662-4a3c-bfa0-2e862d00db2e	f
5a298aed-16ad-443c-97bc-7c0484fa2768	65b16678-cdfb-4d44-9b78-d1e4cbbb9515	f
5a298aed-16ad-443c-97bc-7c0484fa2768	a1a10d1b-c744-404c-b9fc-2566681a1116	f
dd9ee04f-6761-4788-89de-259e46d16093	1be887c1-ee09-4978-aa94-8bdd6164c375	t
dd9ee04f-6761-4788-89de-259e46d16093	f870b6d8-8187-44d4-8bc1-5de67f29d0b8	t
dd9ee04f-6761-4788-89de-259e46d16093	3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	t
dd9ee04f-6761-4788-89de-259e46d16093	9fe5369b-e588-4213-ab80-1081f7a7b767	t
dd9ee04f-6761-4788-89de-259e46d16093	83f5c21e-585e-45bf-94d0-d8f513e31122	t
dd9ee04f-6761-4788-89de-259e46d16093	e2c02738-5d71-4d05-af36-bbc5df14b924	f
dd9ee04f-6761-4788-89de-259e46d16093	e1d14222-6662-4a3c-bfa0-2e862d00db2e	f
dd9ee04f-6761-4788-89de-259e46d16093	65b16678-cdfb-4d44-9b78-d1e4cbbb9515	f
dd9ee04f-6761-4788-89de-259e46d16093	a1a10d1b-c744-404c-b9fc-2566681a1116	f
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	1be887c1-ee09-4978-aa94-8bdd6164c375	t
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	f870b6d8-8187-44d4-8bc1-5de67f29d0b8	t
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	t
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	9fe5369b-e588-4213-ab80-1081f7a7b767	t
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	83f5c21e-585e-45bf-94d0-d8f513e31122	t
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	e2c02738-5d71-4d05-af36-bbc5df14b924	f
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	e1d14222-6662-4a3c-bfa0-2e862d00db2e	f
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	65b16678-cdfb-4d44-9b78-d1e4cbbb9515	f
fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	a1a10d1b-c744-404c-b9fc-2566681a1116	f
cff74c4b-1854-433b-b119-9374fd36bb06	1be887c1-ee09-4978-aa94-8bdd6164c375	t
cff74c4b-1854-433b-b119-9374fd36bb06	f870b6d8-8187-44d4-8bc1-5de67f29d0b8	t
cff74c4b-1854-433b-b119-9374fd36bb06	3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	t
cff74c4b-1854-433b-b119-9374fd36bb06	9fe5369b-e588-4213-ab80-1081f7a7b767	t
cff74c4b-1854-433b-b119-9374fd36bb06	83f5c21e-585e-45bf-94d0-d8f513e31122	t
cff74c4b-1854-433b-b119-9374fd36bb06	e2c02738-5d71-4d05-af36-bbc5df14b924	f
cff74c4b-1854-433b-b119-9374fd36bb06	e1d14222-6662-4a3c-bfa0-2e862d00db2e	f
cff74c4b-1854-433b-b119-9374fd36bb06	65b16678-cdfb-4d44-9b78-d1e4cbbb9515	f
cff74c4b-1854-433b-b119-9374fd36bb06	a1a10d1b-c744-404c-b9fc-2566681a1116	f
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	1be887c1-ee09-4978-aa94-8bdd6164c375	t
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	f870b6d8-8187-44d4-8bc1-5de67f29d0b8	t
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	t
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	9fe5369b-e588-4213-ab80-1081f7a7b767	t
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	83f5c21e-585e-45bf-94d0-d8f513e31122	t
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	e2c02738-5d71-4d05-af36-bbc5df14b924	f
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	e1d14222-6662-4a3c-bfa0-2e862d00db2e	f
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	65b16678-cdfb-4d44-9b78-d1e4cbbb9515	f
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	a1a10d1b-c744-404c-b9fc-2566681a1116	f
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	33cea8d0-b96b-4546-9703-41835e684bee	t
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	162c8fc8-a01b-470d-97ad-c37d33b0db02	t
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	t
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	ffc69274-6a58-46e9-89ca-dc90c48571ae	t
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	7fa7e989-2079-40f9-bc88-cc47d25ae231	t
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	d1ec51c5-66b9-41a2-a829-082f1072d896	f
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	3d8869f0-c392-442b-9538-3da055b888d6	f
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	f
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	7ddf47d7-ba36-4f1f-b972-70999ceb66a8	f
2c734bda-b684-4c63-becb-d9c862a36bfb	33cea8d0-b96b-4546-9703-41835e684bee	t
2c734bda-b684-4c63-becb-d9c862a36bfb	162c8fc8-a01b-470d-97ad-c37d33b0db02	t
2c734bda-b684-4c63-becb-d9c862a36bfb	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	t
2c734bda-b684-4c63-becb-d9c862a36bfb	ffc69274-6a58-46e9-89ca-dc90c48571ae	t
2c734bda-b684-4c63-becb-d9c862a36bfb	7fa7e989-2079-40f9-bc88-cc47d25ae231	t
2c734bda-b684-4c63-becb-d9c862a36bfb	d1ec51c5-66b9-41a2-a829-082f1072d896	f
2c734bda-b684-4c63-becb-d9c862a36bfb	3d8869f0-c392-442b-9538-3da055b888d6	f
2c734bda-b684-4c63-becb-d9c862a36bfb	f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	f
2c734bda-b684-4c63-becb-d9c862a36bfb	7ddf47d7-ba36-4f1f-b972-70999ceb66a8	f
1d561b35-f3aa-4e68-9f75-469ca082589c	33cea8d0-b96b-4546-9703-41835e684bee	t
1d561b35-f3aa-4e68-9f75-469ca082589c	162c8fc8-a01b-470d-97ad-c37d33b0db02	t
1d561b35-f3aa-4e68-9f75-469ca082589c	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	t
1d561b35-f3aa-4e68-9f75-469ca082589c	ffc69274-6a58-46e9-89ca-dc90c48571ae	t
1d561b35-f3aa-4e68-9f75-469ca082589c	7fa7e989-2079-40f9-bc88-cc47d25ae231	t
1d561b35-f3aa-4e68-9f75-469ca082589c	d1ec51c5-66b9-41a2-a829-082f1072d896	f
1d561b35-f3aa-4e68-9f75-469ca082589c	3d8869f0-c392-442b-9538-3da055b888d6	f
1d561b35-f3aa-4e68-9f75-469ca082589c	f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	f
1d561b35-f3aa-4e68-9f75-469ca082589c	7ddf47d7-ba36-4f1f-b972-70999ceb66a8	f
c65288d4-879f-40b7-a4f3-d46b7f61163d	33cea8d0-b96b-4546-9703-41835e684bee	t
c65288d4-879f-40b7-a4f3-d46b7f61163d	162c8fc8-a01b-470d-97ad-c37d33b0db02	t
c65288d4-879f-40b7-a4f3-d46b7f61163d	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	t
c65288d4-879f-40b7-a4f3-d46b7f61163d	ffc69274-6a58-46e9-89ca-dc90c48571ae	t
c65288d4-879f-40b7-a4f3-d46b7f61163d	7fa7e989-2079-40f9-bc88-cc47d25ae231	t
c65288d4-879f-40b7-a4f3-d46b7f61163d	d1ec51c5-66b9-41a2-a829-082f1072d896	f
c65288d4-879f-40b7-a4f3-d46b7f61163d	3d8869f0-c392-442b-9538-3da055b888d6	f
c65288d4-879f-40b7-a4f3-d46b7f61163d	f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	f
c65288d4-879f-40b7-a4f3-d46b7f61163d	7ddf47d7-ba36-4f1f-b972-70999ceb66a8	f
e5f5434d-2580-4410-9492-120e2a618e7a	33cea8d0-b96b-4546-9703-41835e684bee	t
e5f5434d-2580-4410-9492-120e2a618e7a	162c8fc8-a01b-470d-97ad-c37d33b0db02	t
e5f5434d-2580-4410-9492-120e2a618e7a	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	t
e5f5434d-2580-4410-9492-120e2a618e7a	ffc69274-6a58-46e9-89ca-dc90c48571ae	t
e5f5434d-2580-4410-9492-120e2a618e7a	7fa7e989-2079-40f9-bc88-cc47d25ae231	t
e5f5434d-2580-4410-9492-120e2a618e7a	d1ec51c5-66b9-41a2-a829-082f1072d896	f
e5f5434d-2580-4410-9492-120e2a618e7a	3d8869f0-c392-442b-9538-3da055b888d6	f
e5f5434d-2580-4410-9492-120e2a618e7a	f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	f
e5f5434d-2580-4410-9492-120e2a618e7a	7ddf47d7-ba36-4f1f-b972-70999ceb66a8	f
39dc6190-8591-442b-ad84-94882ffbbf34	33cea8d0-b96b-4546-9703-41835e684bee	t
39dc6190-8591-442b-ad84-94882ffbbf34	162c8fc8-a01b-470d-97ad-c37d33b0db02	t
39dc6190-8591-442b-ad84-94882ffbbf34	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	t
39dc6190-8591-442b-ad84-94882ffbbf34	ffc69274-6a58-46e9-89ca-dc90c48571ae	t
39dc6190-8591-442b-ad84-94882ffbbf34	7fa7e989-2079-40f9-bc88-cc47d25ae231	t
39dc6190-8591-442b-ad84-94882ffbbf34	d1ec51c5-66b9-41a2-a829-082f1072d896	f
39dc6190-8591-442b-ad84-94882ffbbf34	3d8869f0-c392-442b-9538-3da055b888d6	f
39dc6190-8591-442b-ad84-94882ffbbf34	f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	f
39dc6190-8591-442b-ad84-94882ffbbf34	7ddf47d7-ba36-4f1f-b972-70999ceb66a8	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
e1d14222-6662-4a3c-bfa0-2e862d00db2e	b6ae30de-a298-4048-8a38-8364515324af
d1ec51c5-66b9-41a2-a829-082f1072d896	7778ca2e-c2ed-45f3-a384-4de6842be5b0
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
8391f596-2403-4112-8427-592b18cf0444	Trusted Hosts	33b59376-8366-4d43-a008-09a699620c97	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	33b59376-8366-4d43-a008-09a699620c97	anonymous
72adfc36-ef5b-415a-872e-2cf6beab6969	Consent Required	33b59376-8366-4d43-a008-09a699620c97	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	33b59376-8366-4d43-a008-09a699620c97	anonymous
a9b46b24-37ff-439f-b256-28413cf6544a	Full Scope Disabled	33b59376-8366-4d43-a008-09a699620c97	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	33b59376-8366-4d43-a008-09a699620c97	anonymous
36aca812-dce6-48c2-8ec8-2ad488128ba2	Max Clients Limit	33b59376-8366-4d43-a008-09a699620c97	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	33b59376-8366-4d43-a008-09a699620c97	anonymous
d9e2d18c-cee4-4497-95a3-e8b108c5fa27	Allowed Protocol Mapper Types	33b59376-8366-4d43-a008-09a699620c97	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	33b59376-8366-4d43-a008-09a699620c97	anonymous
7862a077-d30f-4f1d-bf98-23b328b7d509	Allowed Client Scopes	33b59376-8366-4d43-a008-09a699620c97	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	33b59376-8366-4d43-a008-09a699620c97	anonymous
c6b5c398-a23d-4bc9-9d01-4075d39f0278	Allowed Protocol Mapper Types	33b59376-8366-4d43-a008-09a699620c97	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	33b59376-8366-4d43-a008-09a699620c97	authenticated
f5104e92-8d13-4946-a8aa-cf307a97e086	Allowed Client Scopes	33b59376-8366-4d43-a008-09a699620c97	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	33b59376-8366-4d43-a008-09a699620c97	authenticated
d1729774-b05d-42de-9c91-4f8335cc8d88	rsa-generated	33b59376-8366-4d43-a008-09a699620c97	rsa-generated	org.keycloak.keys.KeyProvider	33b59376-8366-4d43-a008-09a699620c97	\N
8df992a9-f113-4267-89db-e215bd97ee86	rsa-enc-generated	33b59376-8366-4d43-a008-09a699620c97	rsa-enc-generated	org.keycloak.keys.KeyProvider	33b59376-8366-4d43-a008-09a699620c97	\N
5eb4b515-058b-4139-ad77-dc8dd63900c6	hmac-generated	33b59376-8366-4d43-a008-09a699620c97	hmac-generated	org.keycloak.keys.KeyProvider	33b59376-8366-4d43-a008-09a699620c97	\N
a76d5f47-69a5-4d2b-997f-24e57818617f	aes-generated	33b59376-8366-4d43-a008-09a699620c97	aes-generated	org.keycloak.keys.KeyProvider	33b59376-8366-4d43-a008-09a699620c97	\N
6c31fe92-0d88-4e2b-87fb-c313eb8d77fa	rsa-generated	c17fc45e-3905-44c8-b28e-8ee1efd0c910	rsa-generated	org.keycloak.keys.KeyProvider	c17fc45e-3905-44c8-b28e-8ee1efd0c910	\N
b6063039-a755-45c9-bf96-164b103ead3e	rsa-enc-generated	c17fc45e-3905-44c8-b28e-8ee1efd0c910	rsa-enc-generated	org.keycloak.keys.KeyProvider	c17fc45e-3905-44c8-b28e-8ee1efd0c910	\N
d2c86f7b-d806-4a36-982e-87fd69a8f11b	hmac-generated	c17fc45e-3905-44c8-b28e-8ee1efd0c910	hmac-generated	org.keycloak.keys.KeyProvider	c17fc45e-3905-44c8-b28e-8ee1efd0c910	\N
0322654e-b1f8-4c16-916b-9605adff84e4	aes-generated	c17fc45e-3905-44c8-b28e-8ee1efd0c910	aes-generated	org.keycloak.keys.KeyProvider	c17fc45e-3905-44c8-b28e-8ee1efd0c910	\N
e4fb889c-46ae-4387-b7ea-bf0b8bd6431d	Trusted Hosts	c17fc45e-3905-44c8-b28e-8ee1efd0c910	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	anonymous
b7898023-9254-4e6d-b29d-f53e813fac14	Consent Required	c17fc45e-3905-44c8-b28e-8ee1efd0c910	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	anonymous
7b667069-c462-47e1-bef0-de8d48dceeb9	Full Scope Disabled	c17fc45e-3905-44c8-b28e-8ee1efd0c910	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	anonymous
f2683483-0c89-4375-9be5-bb3e5c713bc1	Max Clients Limit	c17fc45e-3905-44c8-b28e-8ee1efd0c910	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	anonymous
e5fe260e-5dbf-4e98-891e-195463964726	Allowed Protocol Mapper Types	c17fc45e-3905-44c8-b28e-8ee1efd0c910	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	anonymous
57c690c4-f674-4c70-afd0-2d3918ffa962	Allowed Client Scopes	c17fc45e-3905-44c8-b28e-8ee1efd0c910	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	anonymous
ca01860b-ea2c-4e14-8c17-bb75ae75bbe1	Allowed Protocol Mapper Types	c17fc45e-3905-44c8-b28e-8ee1efd0c910	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	authenticated
586cab95-e12d-4c23-80f1-e442b245381c	Allowed Client Scopes	c17fc45e-3905-44c8-b28e-8ee1efd0c910	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
0b641e3e-4c2b-466e-8724-8e7cc944e6b5	d9e2d18c-cee4-4497-95a3-e8b108c5fa27	allowed-protocol-mapper-types	saml-role-list-mapper
7149bf2d-6499-4607-b683-8baacdda6eb2	d9e2d18c-cee4-4497-95a3-e8b108c5fa27	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7ddcde9c-f143-4c9e-a370-d04fea13b3c0	d9e2d18c-cee4-4497-95a3-e8b108c5fa27	allowed-protocol-mapper-types	oidc-address-mapper
2cd2085f-176f-4ca2-85e7-f8278968409f	d9e2d18c-cee4-4497-95a3-e8b108c5fa27	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
642a5c8d-45c1-4ff5-aee4-b275468dbef4	d9e2d18c-cee4-4497-95a3-e8b108c5fa27	allowed-protocol-mapper-types	saml-user-property-mapper
5ae70289-b3cc-4197-af77-330c94667d29	d9e2d18c-cee4-4497-95a3-e8b108c5fa27	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
bf8bdbf0-3415-40f2-87ee-b739e8bfd614	d9e2d18c-cee4-4497-95a3-e8b108c5fa27	allowed-protocol-mapper-types	saml-user-attribute-mapper
1a04a459-ec0c-4592-88f0-7245ad604f47	d9e2d18c-cee4-4497-95a3-e8b108c5fa27	allowed-protocol-mapper-types	oidc-full-name-mapper
000b1d6a-4d7c-4e59-9d06-29015108dd43	c6b5c398-a23d-4bc9-9d01-4075d39f0278	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3d23eda0-5eb8-4dfb-a540-fb9b0f3b735a	c6b5c398-a23d-4bc9-9d01-4075d39f0278	allowed-protocol-mapper-types	saml-user-attribute-mapper
27f17246-bb6c-4730-903d-46de7212fe3a	c6b5c398-a23d-4bc9-9d01-4075d39f0278	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
49cd5dbb-f17d-4f4d-8f99-62adc1491109	c6b5c398-a23d-4bc9-9d01-4075d39f0278	allowed-protocol-mapper-types	saml-role-list-mapper
cca77c00-fdc2-45b2-bbc2-a9d7e1a36c46	c6b5c398-a23d-4bc9-9d01-4075d39f0278	allowed-protocol-mapper-types	oidc-address-mapper
ac2e813e-e45a-4364-a094-0fb1c96877a3	c6b5c398-a23d-4bc9-9d01-4075d39f0278	allowed-protocol-mapper-types	saml-user-property-mapper
406b54f2-95eb-44f8-bd21-a36a9e60c2a4	c6b5c398-a23d-4bc9-9d01-4075d39f0278	allowed-protocol-mapper-types	oidc-full-name-mapper
67a52be6-1471-4401-9db5-96d404b6be74	c6b5c398-a23d-4bc9-9d01-4075d39f0278	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
69dcb7d9-87f2-49e5-af84-db4f9d7afffe	7862a077-d30f-4f1d-bf98-23b328b7d509	allow-default-scopes	true
8f6dc61a-b85c-4520-9200-e98e1ce53921	8391f596-2403-4112-8427-592b18cf0444	client-uris-must-match	true
3b3fe70a-18f9-408c-b139-0f701f569e9c	8391f596-2403-4112-8427-592b18cf0444	host-sending-registration-request-must-match	true
5961113f-8c4d-4b85-b278-099c84a48d94	36aca812-dce6-48c2-8ec8-2ad488128ba2	max-clients	200
99109664-1aa1-4cdf-81fe-0d8e4334b749	f5104e92-8d13-4946-a8aa-cf307a97e086	allow-default-scopes	true
a1563749-d995-4656-85de-2c71045d07ee	8df992a9-f113-4267-89db-e215bd97ee86	privateKey	MIIEowIBAAKCAQEA+6BZ2PAL/psB8ocnV2kv0b3KWv0wxyZn7vckB8Qu/ilIbLcCKJNX6jQeRwGVNFWm1JuHFsJSAkK8k/lNXlurFbdqlrzE5/g0rTLYLf9hTti6fufxC/+MiOP6RvEXKvV04ePU+jfL9lLwvR1EEsifI6/xQxHgIduFJHsfjTf6TnOU5+gJbcr3u2/o3lMp8+JnHozXwnUZXlKMfkj1+f50kO+3STT8cTrKOnLOb1QAmLKeMzr/RyPI2O/A3YgxQNbWpiwHpPezMKlaPbradRQPHdTZCzMnrmkFBzSG/CMPtnj6CSojOjzQgk1SNpoJRbAx+NK2fZU2BmX5UISjOjM17wIDAQABAoIBABdKcDaVKuRjZaqUxFlMxQkwJ5RaKOiDeg2o9j6lHp0WUNFbSTRcmxUfGN8FWvxaoelpB00zKb3IKUYLG+m203RcTgiWKtBhQu2gg1kSm+eym49BRH28puie2DI2gP36yq8D/y6Ko/LwxL7EgDdljDFp84t75+1KW/MUqxwlCSK3VMhu5CzkZMug5Wpa8wMwMLYOcYT83LKl3P/HSlYAc8IoFDIQi/jdh28vq+LUQLjAScUxeN7p6Gf25aS7VNmcS467MdlCh6zyVDXvRRkzlq6rld76Rrl2vmSxRHwE7EjQWuAbxjrCB/ROnfcCJnYwfS23iWK3LUpxM2ZgM2lxWI0CgYEA/5DZVhG+h3minfs5L/0LAivjHb+G2IzpgI7sfXCEoXMKgzqXTUmFUr4kKaUMhyftxj9Xx6e1s0CI2mCdob8fxQBUGOTiB9laCQxDzqAuRW/vS7oLpwUplX0zOrgw3xB8XDHdc4pChU+15sAQ6QW3u9lbOvoyTe/PuRppFBec9dUCgYEA/A3J5NXsR74s0f97AoER9brmy7JaMjyu9DDYaw/+js1pCEY0tsh+5RZYLZtPcsIq8Q5jA51QsuKHn3Uv/DoHtV+lI9dput114esdxmlnLozu56c5gciMZVCjw++nJLIHhIH577gukKy/Qqf4Nw81hKcOsT70T5MmwTJDWY31CrMCgYEAv2QC32o6fcqh9h4GHeIrNF0ZoVWl7tbYp+ZhRS/Wo/I7lTtzw/WjWuv6uRVZ5H4Km8UkP+lhMfTKiICCjHdNm4M7d8kxXR9xRgVhYoSjIm1JkDSsNVCwa7tvejImp2b5OzI83iJU3vFrEHwWLeySRKPqpqhos+U8cytMNjfY3GECgYATFmw6oySgjjtQr9s95k5Y4I2H0XrZIRVSsrxA51YstEuG7+IgEXDiol2NHpzWoPOli6Rd6rToxxTkM3itzis1Rgf4feCo4QqDUE3R77t7n/qbmmNVe71+EqxEM0riEYVWOI2X5MfJ9vsI7jVy3fj8kbYgIBdaS1d8+/RzvLdY1wKBgGINX0sgg59sG2Un1brsAbcFQrOZmQ0mTBgqxkS5Ee/b/q5Yj4v9fg5/c0wpFNVwaM9MbFk/MFpr9w7TxhGVGCPlig7Sx0ira98HqwEmKxTkl9V5FTegoYZOmQHiYYYIZKCEIjEiyFC7hW+Hv50aJZB/zAyCYWJfdXmXExXX8QMH
8b391e9d-b4ed-4f3b-a1ea-07d18db822e6	8df992a9-f113-4267-89db-e215bd97ee86	keyUse	ENC
3657d0a6-6658-4081-a6d3-dbf37122e005	8df992a9-f113-4267-89db-e215bd97ee86	priority	100
67d4432c-e8bb-4862-9b4b-44d09858e181	8df992a9-f113-4267-89db-e215bd97ee86	certificate	MIICmzCCAYMCBgGKqirsZTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwOTE4MjExOTE0WhcNMzMwOTE4MjEyMDU0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQD7oFnY8Av+mwHyhydXaS/Rvcpa/TDHJmfu9yQHxC7+KUhstwIok1fqNB5HAZU0VabUm4cWwlICQryT+U1eW6sVt2qWvMTn+DStMtgt/2FO2Lp+5/EL/4yI4/pG8Rcq9XTh49T6N8v2UvC9HUQSyJ8jr/FDEeAh24Ukex+NN/pOc5Tn6Altyve7b+jeUynz4mcejNfCdRleUox+SPX5/nSQ77dJNPxxOso6cs5vVACYsp4zOv9HI8jY78DdiDFA1tamLAek97MwqVo9utp1FA8d1NkLMyeuaQUHNIb8Iw+2ePoJKiM6PNCCTVI2mglFsDH40rZ9lTYGZflQhKM6MzXvAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABL/MksbEhNvbv+MtsmWhvhz/adSrq7OVsN4ltXstbueKlusFpI2BpYhntRS358ZITfSHV3pCbX/7rh0RVaipzr5kiVyMz9albTfJbeG9wbHP7CQBsJdrbDgfSeVyce9U/uxAtaqviJg9cqWDyKluP4v0D3xk34AtygONuvuNsp7vqhWzJJyGZxaan1QQ4nyY5mgH0aw9nWrtEXMhsb+hEYyapk5GixYntYLpNOtDPXEfvADZ1zMeLyaDqcwSXMlXcDOcxsW4CaQAgoQg6HHR4K7i883l6azUsCtx9ferFbSyOPTSAIgfkbEm19FFChxSofuU3rGa0EtjMjRVehdAfI=
7e6d3e19-3394-43e3-8277-e3108a406d56	8df992a9-f113-4267-89db-e215bd97ee86	algorithm	RSA-OAEP
721c464e-9359-4a96-841a-87e4a68f0480	d1729774-b05d-42de-9c91-4f8335cc8d88	privateKey	MIIEpAIBAAKCAQEAsgaOeghv+v1nfMZL+f/ZzGKnyuXA63hcdYVFRYL8hHrfayVfPFJG8HUIRtxBaEGDSpKEQ9CW7YoPBnYH3y2bQhrIQJppKcrxMNMqZKKt13PpDf5ppFdQbpLZ3hyW8PbsU80tgFw19p36Lv9+38U1DE/HnuC7vrqO/tfzez1q0jH2KYEsF8WTxZqpK/bzDYRcUJj960kbD3I75T2FVJwGkAYFI8jM3y0ybydgP0l2iynUhkvvxvHDduQMDJPreDD11tjcSSix87NVCC4EW6f1aNDkhbS0az4H0WprPf3H37uFgx6K9C4W97q8A3shudu/Xg7o29SU4htbog1uy9COvwIDAQABAoIBAFG9r/K5aA1TCA7jD+SYxNzTGZ8Qck3MBIwTZrSdiaucrXQJg1pzns3utp+upzujBREbCC8JGhu0beS2EjQ3wRePq436ODovzCHye38csPyB5Kr/u2rximVS+UVCVE4M2oM57OAItuBnNgYZWxyM9KgUA6DgKGRRTbIW3t2h3Cfpc1ygfKu1sVODrPBFOoFHHhRQHKzX+SjLxER5iQiU0vFtqGNimCu53gAOijNuLEDJ/fQDp7pTqoGu/oBWqYnh/X+r7VVmRzc25MFNebgVl0y14fxWlFxgJhWkUjfKm5YhVXFikZucQN5i8Xu7lBEQMzLsdLUYCCZp8rVkVk1L/a0CgYEA48BKTrtUuzhrUPR6Idlkv+YYQcuKqz9YZMTb+5kv1/+XVU/bNLy6vifAduWmjkl9CSgG2L2pgT2jk2W1xp5VVhg44PVXWTWdiuYY9x/0Ku69sxxhrCNMeaQ3PwWpMMwFh6piGArqjmE/tiUI/UI2dXDyvuFrpNIkfXQFDOJwbnUCgYEAyBtY9bL1NBkEPgkle3dTl6PEyi/k1s4mLO4PvmIicI3IDeGBi7YHVN/iP9ln1awn1JYAN2Tt0W4Dv43GGU9zdNG5ghPOpzBulNhvo13mPIhmXSIc2woEquUgSZub3bY4PBsnN3SvHA/pjmXxRjcHoK74gz3SBe1DCah97n66ieMCgYAb9u1o02mo/1l1/D7OzzGmumr6ETL6qfGBlgZo0ztjqzd6uy5wQEgxtxHTx4j26aEXsbl9fXRFsTrXi2KRe7mAs8KwJI/QHVw1xOEF3v+NEflq964qg78NJJPAAkLvAe4f5VTcHOMGDnzTMaLz7eBf9TlpJKah+0eNu+Qu29LwTQKBgQC6x2v9ypC9lCw1i2wFFphcDmz9HD9JkRppDbx8RDVJQc3dxwOYWMv3GRKh7lfRRePXtjt1eSvSNBIjlj22Gkb2X1v8Ymid/cL6BBwQLPFexyJlBBZTDcLVkRDWI/0UsaVD1USBqtRYKTIjzFus4mioPymPtwB2r8PHHBKPrpKHaQKBgQDg13UO4TKnbGJuNFE+D+FY/RpjA6/RCZnwjMMHQ1hh3sOUGfnOxieEPVLq5/cfiUesd+/MrMa9QfT1Tlf2+LgVIsfXhUH8+WSY9Pp5ZeGulpbBcm/M1Uv+oomkJ8v3hcFDv5vahNTg37iwTimxbuZx04sUX4dGeMv/g1N43O4P3w==
29da906f-2d91-4ab6-a1f2-ac631d4027a1	d1729774-b05d-42de-9c91-4f8335cc8d88	certificate	MIICmzCCAYMCBgGKqirrtDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwOTE4MjExOTE0WhcNMzMwOTE4MjEyMDU0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyBo56CG/6/Wd8xkv5/9nMYqfK5cDreFx1hUVFgvyEet9rJV88UkbwdQhG3EFoQYNKkoRD0Jbtig8GdgffLZtCGshAmmkpyvEw0ypkoq3Xc+kN/mmkV1BuktneHJbw9uxTzS2AXDX2nfou/37fxTUMT8ee4Lu+uo7+1/N7PWrSMfYpgSwXxZPFmqkr9vMNhFxQmP3rSRsPcjvlPYVUnAaQBgUjyMzfLTJvJ2A/SXaLKdSGS+/G8cN25AwMk+t4MPXW2NxJKLHzs1UILgRbp/Vo0OSFtLRrPgfRams9/cffu4WDHor0Lhb3urwDeyG5279eDujb1JTiG1uiDW7L0I6/AgMBAAEwDQYJKoZIhvcNAQELBQADggEBACamOkzA0f/N/d9lzGXo100e+Uv9s6rTwNDRJY5XGs+UdcYlKtLkmpSYEiaN0Po4AyeAyjAeu3Ia5yn0G674Jvdd5tg1r40HWDzrT02H03ZPDtQfRE8y/vbwLhVEwiZqcAGH4sq+CkBrMltu1ZaQVJpJfhIDsfz6MaJcZYGsLvt5puzlzWvlr4tnd1GLRmC+d3F1DnVySk8PyQHlEhov/s0SSzVf5MmtBzC5gbYQ8MEd4hhknW0e5TDScnieEgLQOwuaIIsdmiWiiLGMkHMJDvElwQibV46jVXz5HHUQUb/WI7frd6tFnm7I0HT/INetDEe4Fh40T5K3nvCtISXXdpw=
fe00d471-f311-49c7-8a81-4acd77243129	d1729774-b05d-42de-9c91-4f8335cc8d88	keyUse	SIG
c2760b04-808e-46c5-95ad-fb8626ed06d1	d1729774-b05d-42de-9c91-4f8335cc8d88	priority	100
7b9af3ef-f462-4291-931a-d5b1b4e77a33	5eb4b515-058b-4139-ad77-dc8dd63900c6	kid	0dfdbe4f-88ba-439f-8631-1a3ad342ec59
786f5551-a531-4770-9b0c-7ed06cea11c4	5eb4b515-058b-4139-ad77-dc8dd63900c6	secret	dO_6QnXG98__XrUnHRG_o9laB-fqO1BRBiSROJGnFZg8Awh_7-ea8oiuG8hhGN6VPutRsPfVr-jppEKq9u-WZA
3f6dad68-abfd-4eb9-ab77-f26fc2a9b353	5eb4b515-058b-4139-ad77-dc8dd63900c6	algorithm	HS256
9abc100d-78fe-4f24-87b0-c1fc4db8ee7f	5eb4b515-058b-4139-ad77-dc8dd63900c6	priority	100
cbbceb80-8a34-4192-95d8-fa1a89e2af1c	a76d5f47-69a5-4d2b-997f-24e57818617f	kid	e7f976c1-f843-4ce3-97c8-142cdee23bcd
d838d3e9-bf08-4941-8155-0992230db9cb	a76d5f47-69a5-4d2b-997f-24e57818617f	priority	100
27fd8837-2a4f-4e8f-b70f-9256d2858e29	a76d5f47-69a5-4d2b-997f-24e57818617f	secret	mpBDJvdvpRJC72o83aS5Wg
d6c3cfd5-2f52-4e76-8c13-f47adc0bb06d	d2c86f7b-d806-4a36-982e-87fd69a8f11b	algorithm	HS256
50ee8e5f-2239-4720-9ba4-8269b5be7273	d2c86f7b-d806-4a36-982e-87fd69a8f11b	priority	100
cda8a184-43be-455f-ab37-9bea264bc656	d2c86f7b-d806-4a36-982e-87fd69a8f11b	kid	a12484b9-1eae-492c-b8d6-9ce9506c91be
e3f4aabd-2cdc-4fed-a8ea-08d5ce857e7a	d2c86f7b-d806-4a36-982e-87fd69a8f11b	secret	EAxWZQf227VjLnmZ_XMN-CR93uvZLHpulCICmNpaF5P8L4rJHRslk3-gfZtVJL-YariA7IVrYmJectk5qhmd1Q
5e4090f2-0ee6-4074-aa22-54c45163dc72	6c31fe92-0d88-4e2b-87fb-c313eb8d77fa	keyUse	SIG
ba9993d7-239b-416c-98a5-ea94da9e6ba3	6c31fe92-0d88-4e2b-87fb-c313eb8d77fa	certificate	MIICoTCCAYkCBgGKq5JaSDANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAliM19zb2NpYWwwHhcNMjMwOTE5MDM1MTQ5WhcNMzMwOTE5MDM1MzI5WjAUMRIwEAYDVQQDDAliM19zb2NpYWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDN+Ur1+Ci52VrDDiCLxvCsBvUBszg8VCUXM6nG/8IVAszr+pRfgYYTzj93syPwVzMSCHsXU6WwxMYsw2vC3uyDHE9cDQLOV1NqxQCIsdjD+HcEIYOplwnuaHXr2d+n6c5QYbo4mkJ67PGnXep34WsZQC8jsaPVbJtD5pTundJoEXCXQ2axmY562k7k1WB3akfthqTxIulhwAlnoABxn4tKhQNKyUKJQf1ajikut5WOB/8AthDOKQCGiAChI5ouf6Zzy1i86WTrBeDzWNa1Xo6HG50grPcRjIdwQRVftE6kUmqIGfpusGqcCUsvFy1buWwzURJNP92FegW/CHst9Aw/AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAMCV2i7hn7u7cLww9TOiG8z8IinS4zlkUqfpBlv0Qo2NWqRM45Bi/5r0iZ/lKV1WQayXCbjQecMg/MoFcxw2i+ILbr7CMPhkrtwkUraK5tQX9ewaTaOY0l6d7f4u3dxECoHCtbUWXR5BElu1amASOi/k9o2iNXb3ZuBGvbnMvWcX+VZXn7tX1eagN87JgGcoY+M6EYztLBWiqmi1ZOzQuCkAftZQtiZjmYqv8SHu/yDZu1PTdLan6INS1e0voZPS7i+1CXU13hWFLH+Bn6QON/aUM5hVvI1lQ+4iaWqSD3c0pGsqcihz+DlXZhepehcoGKmHuIXp8+d8+DOjxguXyos=
67818a4d-06c5-4e32-a26c-4370ef7c5413	6c31fe92-0d88-4e2b-87fb-c313eb8d77fa	privateKey	MIIEoAIBAAKCAQEAzflK9fgoudlaww4gi8bwrAb1AbM4PFQlFzOpxv/CFQLM6/qUX4GGE84/d7Mj8FczEgh7F1OlsMTGLMNrwt7sgxxPXA0CzldTasUAiLHYw/h3BCGDqZcJ7mh169nfp+nOUGG6OJpCeuzxp13qd+FrGUAvI7Gj1WybQ+aU7p3SaBFwl0NmsZmOetpO5NVgd2pH7Yak8SLpYcAJZ6AAcZ+LSoUDSslCiUH9Wo4pLreVjgf/ALYQzikAhogAoSOaLn+mc8tYvOlk6wXg81jWtV6OhxudIKz3EYyHcEEVX7ROpFJqiBn6brBqnAlLLxctW7lsM1ESTT/dhXoFvwh7LfQMPwIDAQABAoH/TVHHuFq8iKEovdzcjgJs78B5nxAn8n2j1St2ECQlaldV/AxhcxJFwo/2qauvUglp1afy84Hy/bVGr1Pf0y2omyi4obvaODTDAgS+rpGuGkkRl5T9JJLbDfDCU3opYZJJk6/ot/BjnfS6wjLL6zSZ5fpLt82qmSar7x4fykAOCM8J3vuMfL+Y7dD/nKhEvWMxSUV3qHirGNT6R+gFDWGCOQ1yZUh2lvrjLBD228Q0nS5Lm1jw9bXFqJsOXE6HqXZ3vP91JgMKdo/AJCf4QCh1txJ3vDIGxtpNJfw6nXyTvFUG7wXhBfIOyDUWtHkI1h+jAIfI6uI05V/oLO96cuU5AoGBAOzzb9+bWjdAU/wp8Ai/mCCTPj8iO5CWG/IifxZUuWhLmXdsLt28FxBc5/E3pwYN7pARMXhTXrHAG+vIOrwabmrJAFEtug+LN3nbBasej83O2FeVmNH7hoI5LBwBJJTBK4uQyqNH1O3J/rBOUnPjG+QeJKj5FQx2M9SoH4xN9BAJAoGBAN6IVPCoPHOGrOBfpGVPx62u0wsoTqKraDiI1YZTxgH0GfqPI7GYCnyzt2/XSFTyaqg9/SRQkGqQI1FoU3LOjyfzm+O9WfvvHgRB3SFyxWbAb4m4MllfVf7Rn46Lzlkg7fZ/1ZEaAV2UVQFnqfr6dWDa6/rqfqo4nUsP3u7qubwHAoGAXrvtbH8WEKT9bwHtX/IKBmwYJPGw0tvRDHvSR8FT52jiUKbGDgzXQ8mBSiWv93G2gY7+MldSsspV32zMXsxKfRMjt1EK5JAKfAOfPo0XfXdHc6zxznI7kvD8u62RTI/2svQOsD1V2kQ6OY721DJmwkty6MO9MKBJlKorAtNf0tECgYBtjaCDec+I8FxbebptRgF/t/meHJHZ85izfGniX4uzmoDPoXhpDfjbu34rSUkKyO1JNntRTXhLffplMX8jnh1MBdpRG/8Y0HdukR5UQTR9iW9f1Zaz+QNVF839V0aXCmccW4LAlJTnhQb0UhyUuojezegu9xK0qnqFYaLW7CfUMQKBgCjW0wnYbbZpO5mcslLRWaTIqgNOQfo/QHrcMyR7Fg0FKCVXVcDEKa6ko9ZoH6q/w+24Vatvci99+D292gP08fAITE77cgctn6W6dIFgQinv7VagDcsPpIJoH8wVBjJRvVrnjc/zfPm4oAF3gBRsls7d0XLoMtbCuW3SHA5X49lX
c0302f39-de43-4f07-87d1-c310b840b628	6c31fe92-0d88-4e2b-87fb-c313eb8d77fa	priority	100
8e4737aa-bc5b-4abf-8079-4db5e3a4175d	b6063039-a755-45c9-bf96-164b103ead3e	algorithm	RSA-OAEP
d143c00a-b9c5-4ef9-b48f-11686a2b767e	b6063039-a755-45c9-bf96-164b103ead3e	priority	100
efda4886-1e28-4031-a8eb-709390dba917	b6063039-a755-45c9-bf96-164b103ead3e	privateKey	MIIEpAIBAAKCAQEAsuomY6/Q/YT/9CCJ0JgORDYmjRJ/LbdpMPe4e3BTCaxrJ6PaXT1Hcvm7FZR2P7wLslleRXOYJTL3jaGTq6/uuM0NzN/0R1MhGwN4hNBzGc3NLYsBJk1/8uxPwjLSOlAvbm1XlGJv+C6K9LPXYy7xByxm7ZSd4+zPKkKLqltaHJMhtJGT8P3z9s0QVkNX1JpXQJ99IZA7/k7BoQ9/wtQI/rvuTaKJzBq8qp70Dvs8M5m3zTyNf2OTAVkw9TYWI4bu5EV929rwaoXCdjNcLYeaMUQ98mXAD8QrlYK37kbYv1Y1NGW3oiYlAp8/Ap5ffaIP4wBPT/UmOKYWwZbGIGMEoQIDAQABAoIBAADT4CFA7HS9G0QBVzHdqjSQPZBp1VMcUJfB5Zq96RxtLZe4LyfpmH2EgI7if240YVIjY1zAjU51abtq08M3uUvQja+fb5gENJh/5RxULIbM3WtIWSqDXEP+6jA0n6VWaUnCUWU7KVfFZgN+G3vMI/WhCR7bO6RqHDE5WpULVCONXAja9zoHRgAAFzjAQo9RemiZVd3yxky6KL4dKr5QuGTPGI1cY+3bmf2BOzy72LXAyFGiUWik4PwVw7SJWT5VS/b0gm/t3Dke0KkT6/m6hlKuwuxwBPzPMsePoSYsCWNSwln4It6VKKFEJVCl6OMHsOkTtx65PpB0ifQAlILZBFMCgYEA5/QpJlR+JwwIpfje0LpF7+TCZxM/zWnQ3gaNcqk3Tv5tsFzlkZRXGOUvjvnhRc2fbiNtVzhGVyNROejuCUr0WNpujXLeaP1OUNfkCBIxZc6WHQlQe0Y5JoCPwQjvcD4WMm3QkD5m+ZSiIwUhdf5squItNBWp1AtVVj723/gb7pcCgYEAxXZhUnQ/mb07kpvBJsXbCbQuUekuThGAKpXwpmCS+tso7Fl+qOoNO4lLTXfT7FJr8TXeGA0rVutU1/j0f2SSVaZcTsFmPAIVbgy3/dlUwPJxGZCbmD920cZ+reFiecsDNK9fGz4BavcdaQGpNvP0SKEoggRdp7eSjatpAB0ixYcCgYEAyIkbGnxqJLAOug+T87lXxbNtL1hBDQKzBYF8wOjzXGQzyQpHn7k0I93hZCc9T/AaKkqOuZ15ktSB4SM0yOv4nOkcM0Zgazy0fMhp6WBxPKeCuM/YuPtZZaQ4pJdpCw1ie27dpheNR7HtC4HgD/dLU+H/Wsxv61dxDAObxL7oxzkCgYAhK4ajtDVu3PPh59olaj0mPyc8yT/nC1eNT8yyFiz6iNAyC8KUG2UHqEOHCucFnr7VMShSv/uUyUliUka4E6vlSWHeNOy4jd0NtIM/2D89fjxzf/AzPg32pTJogSDqtqieNAt05xCT6Fj/Z7EGMyrI/JFybctRviuXMsEbrMlHhwKBgQCItDwTL8dJuFpEn8I+jp05X/gNvWkzQEq0MyEkpwO8dEGWI5+CHgBbprAidsw3c5mzRxGejt59a7EDklEkQYfTWfx2Kq2uoLDfBEPYA1HFN3+1EGlxbrycguapFqnnnI2WPVgyzlseFi+AvjmH920P3UnykGH5hpqwYMkSxC8iVg==
1b7f3be3-56cb-4d94-b047-4b0d5a7150e6	b6063039-a755-45c9-bf96-164b103ead3e	keyUse	ENC
6cc80f0e-2480-4513-a4d1-8639c187bdab	b6063039-a755-45c9-bf96-164b103ead3e	certificate	MIICoTCCAYkCBgGKq5Ja7zANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAliM19zb2NpYWwwHhcNMjMwOTE5MDM1MTUwWhcNMzMwOTE5MDM1MzMwWjAUMRIwEAYDVQQDDAliM19zb2NpYWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCy6iZjr9D9hP/0IInQmA5ENiaNEn8tt2kw97h7cFMJrGsno9pdPUdy+bsVlHY/vAuyWV5Fc5glMveNoZOrr+64zQ3M3/RHUyEbA3iE0HMZzc0tiwEmTX/y7E/CMtI6UC9ubVeUYm/4Lor0s9djLvEHLGbtlJ3j7M8qQouqW1ockyG0kZPw/fP2zRBWQ1fUmldAn30hkDv+TsGhD3/C1Aj+u+5NoonMGryqnvQO+zwzmbfNPI1/Y5MBWTD1NhYjhu7kRX3b2vBqhcJ2M1wth5oxRD3yZcAPxCuVgrfuRti/VjU0ZbeiJiUCnz8Cnl99og/jAE9P9SY4phbBlsYgYwShAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEm5UNZGLcSeaqxRhIDnWDwPCCA3pOo6rr0oG/FKiYEVwsIE8aO48cL5oz3RhH815do1gp7jk1ylFriAAY2VZtwH/2lDro6Hh1p54oF4qnHN7thq/1KIsNApmg3MOwMCv0sKNChVtmm9+CAyDCUixVJh4EC2YGE82w9XqLoj1ssAQ9qipc3KdQOYwRc7S1MgNjRdhiW06KntySekyc+TH26T/fXqmqrwNzOpRNX95e8wukBpGeq+bTYkqpiGDgvI1kFRCYsM8Tl6aTXgHjgbrJABKSFWRilDFe1ci9eXkJ9fTJbFMPXU/TPiMxZpE3KFxAWmwHdWfI9mh9MET9rkwhw=
0d7761d9-ae70-47c4-971c-d82e67c2a490	0322654e-b1f8-4c16-916b-9605adff84e4	priority	100
d79907ca-269e-4ca0-b055-c51f289865c6	0322654e-b1f8-4c16-916b-9605adff84e4	kid	e42576ed-50cf-429c-8f16-27c02d5abc98
b3b0524f-aeee-4da1-a95e-f9b63ce4c9e6	0322654e-b1f8-4c16-916b-9605adff84e4	secret	HoHT-Rc_PRGs9fj437rcrg
415017cc-1dce-48d4-8ea6-4902bbf18acd	e4fb889c-46ae-4387-b7ea-bf0b8bd6431d	host-sending-registration-request-must-match	true
c8d85bce-6d1b-4057-afdf-c44d4c4e261c	e4fb889c-46ae-4387-b7ea-bf0b8bd6431d	client-uris-must-match	true
270a1f80-bc0f-4e4d-9678-e08afbb52dbc	586cab95-e12d-4c23-80f1-e442b245381c	allow-default-scopes	true
9d75d2c0-46ad-4ff2-b9d9-76df3b9cc3c7	e5fe260e-5dbf-4e98-891e-195463964726	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f910625f-1759-450c-a084-5fe6e25fd108	e5fe260e-5dbf-4e98-891e-195463964726	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
e5c21baf-4575-45f8-8bc9-c1fdd79c0352	e5fe260e-5dbf-4e98-891e-195463964726	allowed-protocol-mapper-types	oidc-address-mapper
76d17ce7-21b3-491b-ab45-7a728d39ee96	e5fe260e-5dbf-4e98-891e-195463964726	allowed-protocol-mapper-types	saml-user-attribute-mapper
6fc01e8c-4a50-4826-bea1-e6298f50495b	e5fe260e-5dbf-4e98-891e-195463964726	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2b43a360-a714-4d20-87cf-651ed66621c0	e5fe260e-5dbf-4e98-891e-195463964726	allowed-protocol-mapper-types	saml-role-list-mapper
1940cbf5-410a-475f-b4b2-b02f49a329a8	e5fe260e-5dbf-4e98-891e-195463964726	allowed-protocol-mapper-types	oidc-full-name-mapper
c9809522-33b5-4aeb-bb44-bf1fdc3c2c4f	e5fe260e-5dbf-4e98-891e-195463964726	allowed-protocol-mapper-types	saml-user-property-mapper
751e1ce7-999d-49e3-868b-039604ca789f	f2683483-0c89-4375-9be5-bb3e5c713bc1	max-clients	200
14c99f00-e156-41d0-a2ea-dc6a7218b7d0	ca01860b-ea2c-4e14-8c17-bb75ae75bbe1	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7ff1b8cd-5476-4bd2-a875-1368365edca6	ca01860b-ea2c-4e14-8c17-bb75ae75bbe1	allowed-protocol-mapper-types	saml-role-list-mapper
420311f8-118b-4903-87e8-6d18b456fde5	ca01860b-ea2c-4e14-8c17-bb75ae75bbe1	allowed-protocol-mapper-types	oidc-full-name-mapper
e4098c31-6974-40e1-88b0-540120d5a78e	ca01860b-ea2c-4e14-8c17-bb75ae75bbe1	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6f54b3e4-a47a-45c9-906b-6f54fac76c17	ca01860b-ea2c-4e14-8c17-bb75ae75bbe1	allowed-protocol-mapper-types	saml-user-attribute-mapper
7bfedce6-62e0-4f47-a440-26ce86a92794	ca01860b-ea2c-4e14-8c17-bb75ae75bbe1	allowed-protocol-mapper-types	oidc-address-mapper
79751a59-d505-4f83-b88c-80ed2176f44a	ca01860b-ea2c-4e14-8c17-bb75ae75bbe1	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
13d6a5fb-1077-4e5f-8462-6553d73a7415	ca01860b-ea2c-4e14-8c17-bb75ae75bbe1	allowed-protocol-mapper-types	saml-user-property-mapper
7d05f506-f6ce-440a-ae78-128309a86202	57c690c4-f674-4c70-afd0-2d3918ffa962	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.composite_role (composite, child_role) FROM stdin;
fbfa750c-7647-4280-a345-71b47a95830b	49a4ab9c-0aa7-4368-9a05-369be22f229c
fbfa750c-7647-4280-a345-71b47a95830b	5fbbdf71-fb1a-41a2-b4da-40c5a600c571
fbfa750c-7647-4280-a345-71b47a95830b	ec08c8c8-e95e-4dcf-aeaa-4af6b4fe71e4
fbfa750c-7647-4280-a345-71b47a95830b	d9d14516-9b94-4d3b-b86f-64f7c82b01f5
fbfa750c-7647-4280-a345-71b47a95830b	b2402651-cf7e-4419-a92f-46fa93de0de0
fbfa750c-7647-4280-a345-71b47a95830b	1d6b767f-2048-4924-96e0-1442e5965046
fbfa750c-7647-4280-a345-71b47a95830b	5fcfdd70-f8cb-431e-a275-e03f69d19274
fbfa750c-7647-4280-a345-71b47a95830b	26aad392-4686-4cc4-a411-151c8909b5c6
fbfa750c-7647-4280-a345-71b47a95830b	e9e3baf0-0bd1-4b10-b5a7-9aa612f6e3cf
fbfa750c-7647-4280-a345-71b47a95830b	db79bd3f-22d3-4cb5-ac6b-46ffe301a41e
fbfa750c-7647-4280-a345-71b47a95830b	f654233d-fc73-4167-972d-0128c1aae116
fbfa750c-7647-4280-a345-71b47a95830b	259ecc04-db97-4140-b2be-a3926a5513b4
fbfa750c-7647-4280-a345-71b47a95830b	6640f68e-4f1f-4540-ad7f-818fde88c052
fbfa750c-7647-4280-a345-71b47a95830b	d71c4569-cb42-4afa-9685-48337d282d6d
fbfa750c-7647-4280-a345-71b47a95830b	2eda0201-f8e7-4e32-a7d5-3621b09cc115
fbfa750c-7647-4280-a345-71b47a95830b	8e9c8758-3cfe-4681-bb4e-c48f4a9583e6
fbfa750c-7647-4280-a345-71b47a95830b	001af13a-6ca0-498b-ade4-50bb2775a872
fbfa750c-7647-4280-a345-71b47a95830b	b300efb9-7220-4911-be48-daf96d08b45f
4cdb3271-40fa-4ade-9a96-8fc23dee94a0	65099962-1c1b-4e43-810c-1b40ba88fc3a
b2402651-cf7e-4419-a92f-46fa93de0de0	8e9c8758-3cfe-4681-bb4e-c48f4a9583e6
d9d14516-9b94-4d3b-b86f-64f7c82b01f5	2eda0201-f8e7-4e32-a7d5-3621b09cc115
d9d14516-9b94-4d3b-b86f-64f7c82b01f5	b300efb9-7220-4911-be48-daf96d08b45f
4cdb3271-40fa-4ade-9a96-8fc23dee94a0	3a46b9fe-ad0c-4ceb-be9c-820527bf3bdf
3a46b9fe-ad0c-4ceb-be9c-820527bf3bdf	3a0e1644-9465-442a-9359-3ba3a605a93a
4e7e79e3-fcf0-4928-a896-73fe5e63441d	a3c8bfa5-4ca0-4fd2-89f2-b3e501d31f6e
fbfa750c-7647-4280-a345-71b47a95830b	a25d9520-8de9-4c4c-9102-34b36a64141c
4cdb3271-40fa-4ade-9a96-8fc23dee94a0	b6ae30de-a298-4048-8a38-8364515324af
4cdb3271-40fa-4ade-9a96-8fc23dee94a0	97f87c09-a15a-45ad-9ba9-95aaaf762573
fbfa750c-7647-4280-a345-71b47a95830b	9f86ec7c-c3f5-49a4-97f0-8094c00be467
fbfa750c-7647-4280-a345-71b47a95830b	a6a30443-ce48-4df1-b7bb-1e7ec9d0ff8d
fbfa750c-7647-4280-a345-71b47a95830b	1fd9ad50-e285-4f65-88c1-03649462e61e
fbfa750c-7647-4280-a345-71b47a95830b	62f30aaa-7b3c-4afa-b463-e982d90d0f37
fbfa750c-7647-4280-a345-71b47a95830b	62198104-c5f6-45a3-88df-0591b1187e5d
fbfa750c-7647-4280-a345-71b47a95830b	9d04bd3f-015b-4e59-b103-3f89e92340f3
fbfa750c-7647-4280-a345-71b47a95830b	45c81686-6e8e-40d9-9a18-aea1d438c325
fbfa750c-7647-4280-a345-71b47a95830b	c1ab0c95-1843-4e8b-b29e-052430e10657
fbfa750c-7647-4280-a345-71b47a95830b	a0a803ff-a3fd-4fed-96ee-79ad451c6c29
fbfa750c-7647-4280-a345-71b47a95830b	75b02cd1-f8e0-4280-bd18-cefeb0ffb7c0
fbfa750c-7647-4280-a345-71b47a95830b	c047a023-29b0-4a2c-bf96-07ce3c37a013
fbfa750c-7647-4280-a345-71b47a95830b	a1b3eb85-f471-4ec5-8f6b-751db874d920
fbfa750c-7647-4280-a345-71b47a95830b	f7572420-3328-4489-8c62-9832d4ce798f
fbfa750c-7647-4280-a345-71b47a95830b	7e4e11e3-1638-4d1c-98b7-b20974b461ff
fbfa750c-7647-4280-a345-71b47a95830b	a0137cc9-4b0c-4041-a28e-43bc4fcc69ca
fbfa750c-7647-4280-a345-71b47a95830b	4d7f1eb0-627e-41f2-9f72-842f925fc13b
fbfa750c-7647-4280-a345-71b47a95830b	73a6849b-46a8-4355-ba9a-e2570f1a6f34
1fd9ad50-e285-4f65-88c1-03649462e61e	73a6849b-46a8-4355-ba9a-e2570f1a6f34
1fd9ad50-e285-4f65-88c1-03649462e61e	7e4e11e3-1638-4d1c-98b7-b20974b461ff
62f30aaa-7b3c-4afa-b463-e982d90d0f37	a0137cc9-4b0c-4041-a28e-43bc4fcc69ca
8448753e-c2be-407d-9e58-607c7706bacd	fbf08c80-2879-4ae1-a58b-2078b685f3f3
8448753e-c2be-407d-9e58-607c7706bacd	28e57ef4-026f-4821-9655-c3cd79956027
8448753e-c2be-407d-9e58-607c7706bacd	e32b9c5c-329c-484e-b4aa-dba6b2dc0d34
8448753e-c2be-407d-9e58-607c7706bacd	a16845fd-ed4c-464f-9e3b-7901178069ec
8448753e-c2be-407d-9e58-607c7706bacd	dca43cbe-527d-4d91-84d8-06f124c6dece
8448753e-c2be-407d-9e58-607c7706bacd	fe1e3b7b-2c1f-4fe4-95e8-79fa7f16ea4d
8448753e-c2be-407d-9e58-607c7706bacd	66d80ae0-103c-48d0-8288-fd5216f213f5
8448753e-c2be-407d-9e58-607c7706bacd	a7198271-810f-4866-b6ab-dcb413c8b06d
8448753e-c2be-407d-9e58-607c7706bacd	56d3eec5-7f10-49b8-a3c5-1535f534e696
8448753e-c2be-407d-9e58-607c7706bacd	ef987acb-5534-4fee-8bae-c20fd614502e
8448753e-c2be-407d-9e58-607c7706bacd	c59ccaa8-7ed8-4c3a-8edf-9eca5c401443
8448753e-c2be-407d-9e58-607c7706bacd	a63310e2-8a08-4750-a388-bad7aa9c8d9a
8448753e-c2be-407d-9e58-607c7706bacd	25949a82-5db9-4007-a63b-8b2a0750d965
8448753e-c2be-407d-9e58-607c7706bacd	db471d81-eed0-4599-8d88-7277dd422b3d
8448753e-c2be-407d-9e58-607c7706bacd	68865cfd-5ad6-4588-9aee-058c9aa1c446
8448753e-c2be-407d-9e58-607c7706bacd	347fe5bb-7b8d-4b6b-aa16-d5a421779887
8448753e-c2be-407d-9e58-607c7706bacd	c9958e02-5671-4510-b83b-bda6fbe4fa5a
2b65f79c-3fc9-4bb6-a320-464e08df72eb	010ac6b8-0552-4419-a645-aaf949d5bb0f
a16845fd-ed4c-464f-9e3b-7901178069ec	68865cfd-5ad6-4588-9aee-058c9aa1c446
e32b9c5c-329c-484e-b4aa-dba6b2dc0d34	c9958e02-5671-4510-b83b-bda6fbe4fa5a
e32b9c5c-329c-484e-b4aa-dba6b2dc0d34	db471d81-eed0-4599-8d88-7277dd422b3d
2b65f79c-3fc9-4bb6-a320-464e08df72eb	6da4449a-e616-4f00-b7cc-345b996b5130
6da4449a-e616-4f00-b7cc-345b996b5130	26b04a6a-b518-4835-b4b6-e57a746aaffe
1a417a29-ebfc-4bd2-a721-343c93f135bc	d4d061a0-39f6-4242-a85e-3e04635321ca
fbfa750c-7647-4280-a345-71b47a95830b	13978d0a-eca5-4ebe-ac33-53c2e9d0602c
8448753e-c2be-407d-9e58-607c7706bacd	72e05a68-ec26-4df4-8dbe-421f36d348dc
2b65f79c-3fc9-4bb6-a320-464e08df72eb	7778ca2e-c2ed-45f3-a384-4de6842be5b0
2b65f79c-3fc9-4bb6-a320-464e08df72eb	3129c719-ffff-4525-8f08-46ba5ebca12d
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
e06e9e78-456e-4d5d-8063-0df79efa64c1	\N	password	1f96089b-9c8a-4efa-aab9-84f1db2c61bf	1695072054863	\N	{"value":"4pNxYS5rQ2a6BFGy4B6D7ezoiU9w45EDo7YaAcaRucU=","salt":"7nLNnuS+1kZd4NMXAjxBGQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-18 21:20:51.276568	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.20.0	\N	\N	5072050819
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-18 21:20:51.282169	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.20.0	\N	\N	5072050819
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-18 21:20:51.326316	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.20.0	\N	\N	5072050819
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-18 21:20:51.331275	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.20.0	\N	\N	5072050819
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-18 21:20:51.429038	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.20.0	\N	\N	5072050819
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-18 21:20:51.431646	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.20.0	\N	\N	5072050819
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-18 21:20:51.519607	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.20.0	\N	\N	5072050819
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-18 21:20:51.521921	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.20.0	\N	\N	5072050819
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-18 21:20:51.526967	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.20.0	\N	\N	5072050819
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-18 21:20:51.616981	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.20.0	\N	\N	5072050819
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-18 21:20:51.665621	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	5072050819
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-18 21:20:51.668459	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	5072050819
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-18 21:20:51.683356	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	5072050819
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-18 21:20:51.709112	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.20.0	\N	\N	5072050819
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-18 21:20:51.711704	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	5072050819
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-18 21:20:51.714187	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.20.0	\N	\N	5072050819
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-18 21:20:51.717145	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.20.0	\N	\N	5072050819
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-18 21:20:51.755795	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.20.0	\N	\N	5072050819
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-18 21:20:51.795071	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.20.0	\N	\N	5072050819
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-18 21:20:51.801083	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.20.0	\N	\N	5072050819
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-18 21:20:51.80349	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.20.0	\N	\N	5072050819
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-18 21:20:51.806908	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.20.0	\N	\N	5072050819
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-18 21:20:51.827399	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.20.0	\N	\N	5072050819
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-18 21:20:51.833141	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.20.0	\N	\N	5072050819
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-18 21:20:51.83518	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.20.0	\N	\N	5072050819
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-18 21:20:51.883414	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.20.0	\N	\N	5072050819
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-18 21:20:51.967515	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.20.0	\N	\N	5072050819
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-18 21:20:51.970705	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.20.0	\N	\N	5072050819
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-18 21:20:52.045086	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.20.0	\N	\N	5072050819
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-18 21:20:52.059287	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.20.0	\N	\N	5072050819
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-18 21:20:52.077484	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.20.0	\N	\N	5072050819
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-18 21:20:52.083163	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.20.0	\N	\N	5072050819
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-18 21:20:52.091994	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	5072050819
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-18 21:20:52.094422	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.20.0	\N	\N	5072050819
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-18 21:20:52.123875	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.20.0	\N	\N	5072050819
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-18 21:20:52.129457	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.20.0	\N	\N	5072050819
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-18 21:20:52.137383	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	5072050819
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-18 21:20:52.142276	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.20.0	\N	\N	5072050819
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-18 21:20:52.147691	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.20.0	\N	\N	5072050819
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-18 21:20:52.149601	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.20.0	\N	\N	5072050819
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-18 21:20:52.151895	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.20.0	\N	\N	5072050819
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-18 21:20:52.157158	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.20.0	\N	\N	5072050819
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-18 21:20:52.334322	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.20.0	\N	\N	5072050819
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-18 21:20:52.338782	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.20.0	\N	\N	5072050819
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-18 21:20:52.34383	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.20.0	\N	\N	5072050819
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-18 21:20:52.34903	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.20.0	\N	\N	5072050819
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-18 21:20:52.35096	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.20.0	\N	\N	5072050819
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-18 21:20:52.387309	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.20.0	\N	\N	5072050819
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-18 21:20:52.391554	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.20.0	\N	\N	5072050819
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-18 21:20:52.442594	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.20.0	\N	\N	5072050819
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-18 21:20:52.484012	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.20.0	\N	\N	5072050819
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-18 21:20:52.487632	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	5072050819
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-18 21:20:52.490129	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.20.0	\N	\N	5072050819
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-18 21:20:52.493439	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.20.0	\N	\N	5072050819
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-18 21:20:52.501087	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.20.0	\N	\N	5072050819
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-18 21:20:52.505502	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.20.0	\N	\N	5072050819
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-18 21:20:52.528349	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.20.0	\N	\N	5072050819
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-18 21:20:52.618275	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.20.0	\N	\N	5072050819
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-18 21:20:52.643696	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.20.0	\N	\N	5072050819
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-18 21:20:52.648487	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.20.0	\N	\N	5072050819
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-18 21:20:52.656449	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.20.0	\N	\N	5072050819
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-18 21:20:52.663601	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.20.0	\N	\N	5072050819
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-18 21:20:52.667631	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.20.0	\N	\N	5072050819
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-18 21:20:52.6705	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.20.0	\N	\N	5072050819
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-18 21:20:52.673725	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.20.0	\N	\N	5072050819
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-18 21:20:52.691641	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.20.0	\N	\N	5072050819
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-18 21:20:52.699358	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.20.0	\N	\N	5072050819
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-18 21:20:52.703746	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.20.0	\N	\N	5072050819
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-18 21:20:52.715218	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.20.0	\N	\N	5072050819
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-18 21:20:52.72048	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.20.0	\N	\N	5072050819
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-18 21:20:52.724795	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.20.0	\N	\N	5072050819
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-18 21:20:52.73061	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	5072050819
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-18 21:20:52.735354	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	5072050819
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-18 21:20:52.737265	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	5072050819
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-18 21:20:52.749268	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.20.0	\N	\N	5072050819
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-18 21:20:52.756717	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.20.0	\N	\N	5072050819
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-18 21:20:52.761472	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.20.0	\N	\N	5072050819
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-18 21:20:52.763387	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.20.0	\N	\N	5072050819
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-18 21:20:52.782708	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.20.0	\N	\N	5072050819
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-18 21:20:52.784543	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.20.0	\N	\N	5072050819
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-18 21:20:52.792684	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.20.0	\N	\N	5072050819
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-18 21:20:52.79488	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	5072050819
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-18 21:20:52.799795	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	5072050819
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-18 21:20:52.801659	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	5072050819
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-18 21:20:52.809999	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.20.0	\N	\N	5072050819
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-18 21:20:52.816421	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.20.0	\N	\N	5072050819
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-18 21:20:52.824264	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.20.0	\N	\N	5072050819
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-18 21:20:52.83621	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.20.0	\N	\N	5072050819
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-18 21:20:52.843726	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.20.0	\N	\N	5072050819
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-18 21:20:52.848942	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.20.0	\N	\N	5072050819
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-18 21:20:52.856589	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	5072050819
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-18 21:20:52.863384	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.20.0	\N	\N	5072050819
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-18 21:20:52.866087	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.20.0	\N	\N	5072050819
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-18 21:20:52.875923	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.20.0	\N	\N	5072050819
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-18 21:20:52.878126	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.20.0	\N	\N	5072050819
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-18 21:20:52.883474	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.20.0	\N	\N	5072050819
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-18 21:20:52.899132	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	5072050819
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-18 21:20:52.901776	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	5072050819
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-18 21:20:52.911718	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	5072050819
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-18 21:20:52.920152	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	5072050819
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-18 21:20:52.922124	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	5072050819
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-18 21:20:52.929387	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.20.0	\N	\N	5072050819
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-18 21:20:52.93608	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.20.0	\N	\N	5072050819
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-18 21:20:52.941846	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.20.0	\N	\N	5072050819
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-18 21:20:52.949478	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.20.0	\N	\N	5072050819
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-18 21:20:52.956203	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.20.0	\N	\N	5072050819
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-18 21:20:52.961668	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.20.0	\N	\N	5072050819
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-09-18 21:20:52.968728	108	EXECUTED	8:05c99fc610845ef66ee812b7921af0ef	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.20.0	\N	\N	5072050819
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-09-18 21:20:52.970544	109	MARK_RAN	8:314e803baf2f1ec315b3464e398b8247	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.20.0	\N	\N	5072050819
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-09-18 21:20:52.97802	110	EXECUTED	8:56e4677e7e12556f70b604c573840100	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	5072050819
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2023-09-18 21:20:52.982831	111	EXECUTED	8:8806cb33d2a546ce770384bf98cf6eac	customChange		\N	4.20.0	\N	\N	5072050819
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-09-18 21:20:53.018503	112	EXECUTED	8:fdb2924649d30555ab3a1744faba4928	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.20.0	\N	\N	5072050819
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-09-18 21:20:53.020442	113	MARK_RAN	8:1c96cc2b10903bd07a03670098d67fd6	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.20.0	\N	\N	5072050819
22.0.0-17484	keycloak	META-INF/jpa-changelog-22.0.0.xml	2023-09-18 21:20:53.026218	114	EXECUTED	8:4c3d4e8b142a66fcdf21b89a4dd33301	customChange		\N	4.20.0	\N	\N	5072050819
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
33b59376-8366-4d43-a008-09a699620c97	e1d14222-6662-4a3c-bfa0-2e862d00db2e	f
33b59376-8366-4d43-a008-09a699620c97	cc763bc9-c56c-4638-adb5-44ee6d897432	t
33b59376-8366-4d43-a008-09a699620c97	83f5c21e-585e-45bf-94d0-d8f513e31122	t
33b59376-8366-4d43-a008-09a699620c97	f870b6d8-8187-44d4-8bc1-5de67f29d0b8	t
33b59376-8366-4d43-a008-09a699620c97	65b16678-cdfb-4d44-9b78-d1e4cbbb9515	f
33b59376-8366-4d43-a008-09a699620c97	a1a10d1b-c744-404c-b9fc-2566681a1116	f
33b59376-8366-4d43-a008-09a699620c97	1be887c1-ee09-4978-aa94-8bdd6164c375	t
33b59376-8366-4d43-a008-09a699620c97	9fe5369b-e588-4213-ab80-1081f7a7b767	t
33b59376-8366-4d43-a008-09a699620c97	e2c02738-5d71-4d05-af36-bbc5df14b924	f
33b59376-8366-4d43-a008-09a699620c97	3f3ae2a7-dad4-439c-aa64-b3cd5a20435e	t
c17fc45e-3905-44c8-b28e-8ee1efd0c910	d1ec51c5-66b9-41a2-a829-082f1072d896	f
c17fc45e-3905-44c8-b28e-8ee1efd0c910	3d5ba115-b7b3-4c9f-8a9f-4f6dc66d411c	t
c17fc45e-3905-44c8-b28e-8ee1efd0c910	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e	t
c17fc45e-3905-44c8-b28e-8ee1efd0c910	162c8fc8-a01b-470d-97ad-c37d33b0db02	t
c17fc45e-3905-44c8-b28e-8ee1efd0c910	f1b7acd9-1d20-4f9f-a91b-f4a514d3df03	f
c17fc45e-3905-44c8-b28e-8ee1efd0c910	3d8869f0-c392-442b-9538-3da055b888d6	f
c17fc45e-3905-44c8-b28e-8ee1efd0c910	ffc69274-6a58-46e9-89ca-dc90c48571ae	t
c17fc45e-3905-44c8-b28e-8ee1efd0c910	33cea8d0-b96b-4546-9703-41835e684bee	t
c17fc45e-3905-44c8-b28e-8ee1efd0c910	7ddf47d7-ba36-4f1f-b972-70999ceb66a8	f
c17fc45e-3905-44c8-b28e-8ee1efd0c910	7fa7e989-2079-40f9-bc88-cc47d25ae231	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
4cdb3271-40fa-4ade-9a96-8fc23dee94a0	33b59376-8366-4d43-a008-09a699620c97	f	${role_default-roles}	default-roles-master	33b59376-8366-4d43-a008-09a699620c97	\N	\N
49a4ab9c-0aa7-4368-9a05-369be22f229c	33b59376-8366-4d43-a008-09a699620c97	f	${role_create-realm}	create-realm	33b59376-8366-4d43-a008-09a699620c97	\N	\N
fbfa750c-7647-4280-a345-71b47a95830b	33b59376-8366-4d43-a008-09a699620c97	f	${role_admin}	admin	33b59376-8366-4d43-a008-09a699620c97	\N	\N
5fbbdf71-fb1a-41a2-b4da-40c5a600c571	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_create-client}	create-client	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
ec08c8c8-e95e-4dcf-aeaa-4af6b4fe71e4	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_view-realm}	view-realm	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
d9d14516-9b94-4d3b-b86f-64f7c82b01f5	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_view-users}	view-users	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
b2402651-cf7e-4419-a92f-46fa93de0de0	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_view-clients}	view-clients	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
1d6b767f-2048-4924-96e0-1442e5965046	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_view-events}	view-events	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
5fcfdd70-f8cb-431e-a275-e03f69d19274	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_view-identity-providers}	view-identity-providers	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
26aad392-4686-4cc4-a411-151c8909b5c6	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_view-authorization}	view-authorization	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
e9e3baf0-0bd1-4b10-b5a7-9aa612f6e3cf	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_manage-realm}	manage-realm	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
db79bd3f-22d3-4cb5-ac6b-46ffe301a41e	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_manage-users}	manage-users	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
f654233d-fc73-4167-972d-0128c1aae116	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_manage-clients}	manage-clients	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
259ecc04-db97-4140-b2be-a3926a5513b4	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_manage-events}	manage-events	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
6640f68e-4f1f-4540-ad7f-818fde88c052	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_manage-identity-providers}	manage-identity-providers	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
d71c4569-cb42-4afa-9685-48337d282d6d	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_manage-authorization}	manage-authorization	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
2eda0201-f8e7-4e32-a7d5-3621b09cc115	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_query-users}	query-users	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
8e9c8758-3cfe-4681-bb4e-c48f4a9583e6	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_query-clients}	query-clients	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
001af13a-6ca0-498b-ade4-50bb2775a872	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_query-realms}	query-realms	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
b300efb9-7220-4911-be48-daf96d08b45f	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_query-groups}	query-groups	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
65099962-1c1b-4e43-810c-1b40ba88fc3a	be31244a-8352-4068-a494-0611b28f8a6d	t	${role_view-profile}	view-profile	33b59376-8366-4d43-a008-09a699620c97	be31244a-8352-4068-a494-0611b28f8a6d	\N
3a46b9fe-ad0c-4ceb-be9c-820527bf3bdf	be31244a-8352-4068-a494-0611b28f8a6d	t	${role_manage-account}	manage-account	33b59376-8366-4d43-a008-09a699620c97	be31244a-8352-4068-a494-0611b28f8a6d	\N
3a0e1644-9465-442a-9359-3ba3a605a93a	be31244a-8352-4068-a494-0611b28f8a6d	t	${role_manage-account-links}	manage-account-links	33b59376-8366-4d43-a008-09a699620c97	be31244a-8352-4068-a494-0611b28f8a6d	\N
a2d40750-3884-4a3b-b09b-ca26a7d0ec17	be31244a-8352-4068-a494-0611b28f8a6d	t	${role_view-applications}	view-applications	33b59376-8366-4d43-a008-09a699620c97	be31244a-8352-4068-a494-0611b28f8a6d	\N
a3c8bfa5-4ca0-4fd2-89f2-b3e501d31f6e	be31244a-8352-4068-a494-0611b28f8a6d	t	${role_view-consent}	view-consent	33b59376-8366-4d43-a008-09a699620c97	be31244a-8352-4068-a494-0611b28f8a6d	\N
4e7e79e3-fcf0-4928-a896-73fe5e63441d	be31244a-8352-4068-a494-0611b28f8a6d	t	${role_manage-consent}	manage-consent	33b59376-8366-4d43-a008-09a699620c97	be31244a-8352-4068-a494-0611b28f8a6d	\N
ff9f7680-e5c4-4516-8acf-004efe2036e6	be31244a-8352-4068-a494-0611b28f8a6d	t	${role_view-groups}	view-groups	33b59376-8366-4d43-a008-09a699620c97	be31244a-8352-4068-a494-0611b28f8a6d	\N
a3272a98-9c53-4f2c-8ddd-659e74185643	be31244a-8352-4068-a494-0611b28f8a6d	t	${role_delete-account}	delete-account	33b59376-8366-4d43-a008-09a699620c97	be31244a-8352-4068-a494-0611b28f8a6d	\N
83360758-0bf7-4996-ab76-adcbbca33aa0	fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	t	${role_read-token}	read-token	33b59376-8366-4d43-a008-09a699620c97	fa3b1567-759a-4c65-b0ce-a7e8dc2a199b	\N
a25d9520-8de9-4c4c-9102-34b36a64141c	cff74c4b-1854-433b-b119-9374fd36bb06	t	${role_impersonation}	impersonation	33b59376-8366-4d43-a008-09a699620c97	cff74c4b-1854-433b-b119-9374fd36bb06	\N
b6ae30de-a298-4048-8a38-8364515324af	33b59376-8366-4d43-a008-09a699620c97	f	${role_offline-access}	offline_access	33b59376-8366-4d43-a008-09a699620c97	\N	\N
97f87c09-a15a-45ad-9ba9-95aaaf762573	33b59376-8366-4d43-a008-09a699620c97	f	${role_uma_authorization}	uma_authorization	33b59376-8366-4d43-a008-09a699620c97	\N	\N
2b65f79c-3fc9-4bb6-a320-464e08df72eb	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f	${role_default-roles}	default-roles-b3_social	c17fc45e-3905-44c8-b28e-8ee1efd0c910	\N	\N
9f86ec7c-c3f5-49a4-97f0-8094c00be467	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_create-client}	create-client	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
a6a30443-ce48-4df1-b7bb-1e7ec9d0ff8d	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_view-realm}	view-realm	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
1fd9ad50-e285-4f65-88c1-03649462e61e	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_view-users}	view-users	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
62f30aaa-7b3c-4afa-b463-e982d90d0f37	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_view-clients}	view-clients	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
62198104-c5f6-45a3-88df-0591b1187e5d	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_view-events}	view-events	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
9d04bd3f-015b-4e59-b103-3f89e92340f3	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_view-identity-providers}	view-identity-providers	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
45c81686-6e8e-40d9-9a18-aea1d438c325	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_view-authorization}	view-authorization	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
c1ab0c95-1843-4e8b-b29e-052430e10657	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_manage-realm}	manage-realm	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
a0a803ff-a3fd-4fed-96ee-79ad451c6c29	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_manage-users}	manage-users	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
75b02cd1-f8e0-4280-bd18-cefeb0ffb7c0	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_manage-clients}	manage-clients	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
c047a023-29b0-4a2c-bf96-07ce3c37a013	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_manage-events}	manage-events	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
a1b3eb85-f471-4ec5-8f6b-751db874d920	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_manage-identity-providers}	manage-identity-providers	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
f7572420-3328-4489-8c62-9832d4ce798f	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_manage-authorization}	manage-authorization	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
7e4e11e3-1638-4d1c-98b7-b20974b461ff	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_query-users}	query-users	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
a0137cc9-4b0c-4041-a28e-43bc4fcc69ca	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_query-clients}	query-clients	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
4d7f1eb0-627e-41f2-9f72-842f925fc13b	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_query-realms}	query-realms	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
73a6849b-46a8-4355-ba9a-e2570f1a6f34	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_query-groups}	query-groups	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
8448753e-c2be-407d-9e58-607c7706bacd	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_realm-admin}	realm-admin	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
fbf08c80-2879-4ae1-a58b-2078b685f3f3	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_create-client}	create-client	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
28e57ef4-026f-4821-9655-c3cd79956027	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_view-realm}	view-realm	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
e32b9c5c-329c-484e-b4aa-dba6b2dc0d34	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_view-users}	view-users	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
a16845fd-ed4c-464f-9e3b-7901178069ec	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_view-clients}	view-clients	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
dca43cbe-527d-4d91-84d8-06f124c6dece	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_view-events}	view-events	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
fe1e3b7b-2c1f-4fe4-95e8-79fa7f16ea4d	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_view-identity-providers}	view-identity-providers	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
66d80ae0-103c-48d0-8288-fd5216f213f5	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_view-authorization}	view-authorization	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
a7198271-810f-4866-b6ab-dcb413c8b06d	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_manage-realm}	manage-realm	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
56d3eec5-7f10-49b8-a3c5-1535f534e696	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_manage-users}	manage-users	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
ef987acb-5534-4fee-8bae-c20fd614502e	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_manage-clients}	manage-clients	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
c59ccaa8-7ed8-4c3a-8edf-9eca5c401443	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_manage-events}	manage-events	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
a63310e2-8a08-4750-a388-bad7aa9c8d9a	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_manage-identity-providers}	manage-identity-providers	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
25949a82-5db9-4007-a63b-8b2a0750d965	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_manage-authorization}	manage-authorization	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
db471d81-eed0-4599-8d88-7277dd422b3d	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_query-users}	query-users	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
68865cfd-5ad6-4588-9aee-058c9aa1c446	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_query-clients}	query-clients	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
347fe5bb-7b8d-4b6b-aa16-d5a421779887	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_query-realms}	query-realms	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
c9958e02-5671-4510-b83b-bda6fbe4fa5a	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_query-groups}	query-groups	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
010ac6b8-0552-4419-a645-aaf949d5bb0f	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	t	${role_view-profile}	view-profile	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	\N
6da4449a-e616-4f00-b7cc-345b996b5130	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	t	${role_manage-account}	manage-account	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	\N
26b04a6a-b518-4835-b4b6-e57a746aaffe	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	t	${role_manage-account-links}	manage-account-links	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	\N
20876d23-f4e9-4890-ae89-fe1b3ff8b71f	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	t	${role_view-applications}	view-applications	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	\N
d4d061a0-39f6-4242-a85e-3e04635321ca	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	t	${role_view-consent}	view-consent	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	\N
1a417a29-ebfc-4bd2-a721-343c93f135bc	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	t	${role_manage-consent}	manage-consent	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	\N
a0db6382-1486-4374-862f-bbb2ce5f2e2b	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	t	${role_view-groups}	view-groups	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	\N
882c4f85-21a8-47c2-9b17-6a72caca97d8	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	t	${role_delete-account}	delete-account	c17fc45e-3905-44c8-b28e-8ee1efd0c910	a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	\N
13978d0a-eca5-4ebe-ac33-53c2e9d0602c	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	t	${role_impersonation}	impersonation	33b59376-8366-4d43-a008-09a699620c97	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	\N
72e05a68-ec26-4df4-8dbe-421f36d348dc	e5f5434d-2580-4410-9492-120e2a618e7a	t	${role_impersonation}	impersonation	c17fc45e-3905-44c8-b28e-8ee1efd0c910	e5f5434d-2580-4410-9492-120e2a618e7a	\N
e2ed5fcf-139f-4a34-a7de-a0e27b5d3c1c	c65288d4-879f-40b7-a4f3-d46b7f61163d	t	${role_read-token}	read-token	c17fc45e-3905-44c8-b28e-8ee1efd0c910	c65288d4-879f-40b7-a4f3-d46b7f61163d	\N
7778ca2e-c2ed-45f3-a384-4de6842be5b0	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f	${role_offline-access}	offline_access	c17fc45e-3905-44c8-b28e-8ee1efd0c910	\N	\N
3129c719-ffff-4525-8f08-46ba5ebca12d	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f	${role_uma_authorization}	uma_authorization	c17fc45e-3905-44c8-b28e-8ee1efd0c910	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.migration_model (id, version, update_time) FROM stdin;
tyz4a	22.0.1	1695072053
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
17ff4e27-33cc-4f08-9fc3-1b731160509d	audience resolve	openid-connect	oidc-audience-resolve-mapper	5a298aed-16ad-443c-97bc-7c0484fa2768	\N
9a7b8ae7-7e84-4805-8be2-34c9beb21dc9	locale	openid-connect	oidc-usermodel-attribute-mapper	7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	\N
54dbe338-8a40-4a22-8382-9af0df8dcab6	role list	saml	saml-role-list-mapper	\N	cc763bc9-c56c-4638-adb5-44ee6d897432
9ae8b7d2-51d8-447c-a2ad-b4150ec99d78	full name	openid-connect	oidc-full-name-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
b32e74bc-dc43-4548-b9a7-781dad489bda	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
35b685c0-dd96-4a20-b6eb-ef3e8f195e83	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
e857e2d5-64ae-406e-ac60-0bed2d68c2fd	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
eb2ca0f0-e429-4760-9b8b-b1e2410899bd	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
945cc86e-5dd6-41c9-b648-0be000deeade	username	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
a19632b5-8984-4780-90c6-709d35887024	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
d78dcbaa-0b68-4cc2-8f96-f65c1ad926d7	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
2c9922ad-9df2-44ec-8623-20a112221dde	website	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
2c48f39d-2d7f-42fd-9487-176b11d00f46	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
24c6da0c-cdb4-41df-ac6c-ee54fa91b17e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
03a6c4a6-3cc5-47f1-8629-cf7f8d03ed7c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
35f1acd8-0071-4059-b9ef-89d9f7ecea5a	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
446454ca-2301-45c3-9666-db97d11296f8	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	83f5c21e-585e-45bf-94d0-d8f513e31122
891ef29f-a0d2-4c0c-a706-1230804cf8b9	email	openid-connect	oidc-usermodel-attribute-mapper	\N	f870b6d8-8187-44d4-8bc1-5de67f29d0b8
7597afd8-a6eb-4ba0-8998-22a0e5996637	email verified	openid-connect	oidc-usermodel-property-mapper	\N	f870b6d8-8187-44d4-8bc1-5de67f29d0b8
3b4e0a6b-019c-4662-a141-68097980a2a2	address	openid-connect	oidc-address-mapper	\N	65b16678-cdfb-4d44-9b78-d1e4cbbb9515
0a558f83-9165-4103-abfe-03493a26b600	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a1a10d1b-c744-404c-b9fc-2566681a1116
65edf2f4-3f17-4c3f-8796-7cc0429751ed	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a1a10d1b-c744-404c-b9fc-2566681a1116
17144bc5-caa7-4842-9a60-ca5ff951e5c2	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	1be887c1-ee09-4978-aa94-8bdd6164c375
7d3addfb-c089-4b67-a7a1-5364ba9c9f75	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	1be887c1-ee09-4978-aa94-8bdd6164c375
54563b65-b33f-4b7f-bf8b-a781052fe446	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	1be887c1-ee09-4978-aa94-8bdd6164c375
203a5223-66dc-49a3-9c2b-08fe12bb29a5	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	9fe5369b-e588-4213-ab80-1081f7a7b767
f7b9ab49-8655-4a0b-b146-f9a50ae8faac	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	e2c02738-5d71-4d05-af36-bbc5df14b924
15d2fdea-fb4b-457a-aaf1-ba1b69b1ad75	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	e2c02738-5d71-4d05-af36-bbc5df14b924
414d723d-bb5b-4a3b-8e31-110657383148	acr loa level	openid-connect	oidc-acr-mapper	\N	3f3ae2a7-dad4-439c-aa64-b3cd5a20435e
4e440808-3980-4a0c-9ed8-8cb4c9068a82	audience resolve	openid-connect	oidc-audience-resolve-mapper	2c734bda-b684-4c63-becb-d9c862a36bfb	\N
dee6dae6-5b20-490a-a7d8-f864aa4b4aad	role list	saml	saml-role-list-mapper	\N	3d5ba115-b7b3-4c9f-8a9f-4f6dc66d411c
fe154a93-9494-4a4b-a105-8ef56247e76a	full name	openid-connect	oidc-full-name-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
184b2689-51ac-4fac-9d4b-ef269b78eb19	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
82f716f9-c8ee-4fda-b573-9ffbe1d2f649	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
32f78f1f-7082-44bc-8d2b-204889acd978	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
f9aa8ca8-f5c6-479e-b4ca-2a49709b9d1d	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
c00e620f-ddf1-4b1a-b2e2-4eb522c48113	username	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
7e8f8991-bf8e-447c-a9c8-2b476cacc19d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
aecbdab6-7e0b-4dea-9295-a6992e7b1ebe	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
780268b1-d2f3-4f4c-bb0f-40aaba749499	website	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
99781fed-fa5f-41ea-97c0-0290c7d5dbcb	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
2677b031-e47a-449f-be04-46d5feafeee6	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
f3a0ef13-078e-4da3-8899-9668c64f524b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
b6678e6f-466a-4c2b-996b-0d4f5f68f08f	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
87f19379-1fa7-4a43-80c8-9ff5a69a3342	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	96e62781-d8d4-4b6d-9c85-9ecdb283bf9e
2de01c71-7e6d-4ad8-a52b-db9357641b3e	email	openid-connect	oidc-usermodel-attribute-mapper	\N	162c8fc8-a01b-470d-97ad-c37d33b0db02
c940674c-28a4-4908-bcb4-722ddbb7b8c0	email verified	openid-connect	oidc-usermodel-property-mapper	\N	162c8fc8-a01b-470d-97ad-c37d33b0db02
1717a35e-552d-41f6-b179-028a6ef738a8	address	openid-connect	oidc-address-mapper	\N	f1b7acd9-1d20-4f9f-a91b-f4a514d3df03
eb40a6bd-ce70-41e5-b968-0deed7de455b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	3d8869f0-c392-442b-9538-3da055b888d6
5ba50ef8-48b5-4a9d-936e-f3eeaa38bafc	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	3d8869f0-c392-442b-9538-3da055b888d6
9939a2dc-c7c7-4d67-82eb-b323717a260a	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	ffc69274-6a58-46e9-89ca-dc90c48571ae
2131af9e-0b2e-47f2-bcd5-05f46425405e	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	ffc69274-6a58-46e9-89ca-dc90c48571ae
dff00e7f-b54e-4e06-91ad-d0dd589747eb	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	ffc69274-6a58-46e9-89ca-dc90c48571ae
4327b92c-4447-4675-ade0-9b357d3449e4	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	33cea8d0-b96b-4546-9703-41835e684bee
6f251cd6-ba85-4fe1-b594-64f601a63265	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddf47d7-ba36-4f1f-b972-70999ceb66a8
38dfdc5f-2203-4428-bcf3-a244839254be	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	7ddf47d7-ba36-4f1f-b972-70999ceb66a8
545ad078-c429-4a1f-9ef0-b78ceb1a7b23	acr loa level	openid-connect	oidc-acr-mapper	\N	7fa7e989-2079-40f9-bc88-cc47d25ae231
2f1a4e9b-c3b5-413a-a6c6-cecb5c85e407	locale	openid-connect	oidc-usermodel-attribute-mapper	39dc6190-8591-442b-ad84-94882ffbbf34	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
9a7b8ae7-7e84-4805-8be2-34c9beb21dc9	true	userinfo.token.claim
9a7b8ae7-7e84-4805-8be2-34c9beb21dc9	locale	user.attribute
9a7b8ae7-7e84-4805-8be2-34c9beb21dc9	true	id.token.claim
9a7b8ae7-7e84-4805-8be2-34c9beb21dc9	true	access.token.claim
9a7b8ae7-7e84-4805-8be2-34c9beb21dc9	locale	claim.name
9a7b8ae7-7e84-4805-8be2-34c9beb21dc9	String	jsonType.label
54dbe338-8a40-4a22-8382-9af0df8dcab6	false	single
54dbe338-8a40-4a22-8382-9af0df8dcab6	Basic	attribute.nameformat
54dbe338-8a40-4a22-8382-9af0df8dcab6	Role	attribute.name
03a6c4a6-3cc5-47f1-8629-cf7f8d03ed7c	true	userinfo.token.claim
03a6c4a6-3cc5-47f1-8629-cf7f8d03ed7c	zoneinfo	user.attribute
03a6c4a6-3cc5-47f1-8629-cf7f8d03ed7c	true	id.token.claim
03a6c4a6-3cc5-47f1-8629-cf7f8d03ed7c	true	access.token.claim
03a6c4a6-3cc5-47f1-8629-cf7f8d03ed7c	zoneinfo	claim.name
03a6c4a6-3cc5-47f1-8629-cf7f8d03ed7c	String	jsonType.label
24c6da0c-cdb4-41df-ac6c-ee54fa91b17e	true	userinfo.token.claim
24c6da0c-cdb4-41df-ac6c-ee54fa91b17e	birthdate	user.attribute
24c6da0c-cdb4-41df-ac6c-ee54fa91b17e	true	id.token.claim
24c6da0c-cdb4-41df-ac6c-ee54fa91b17e	true	access.token.claim
24c6da0c-cdb4-41df-ac6c-ee54fa91b17e	birthdate	claim.name
24c6da0c-cdb4-41df-ac6c-ee54fa91b17e	String	jsonType.label
2c48f39d-2d7f-42fd-9487-176b11d00f46	true	userinfo.token.claim
2c48f39d-2d7f-42fd-9487-176b11d00f46	gender	user.attribute
2c48f39d-2d7f-42fd-9487-176b11d00f46	true	id.token.claim
2c48f39d-2d7f-42fd-9487-176b11d00f46	true	access.token.claim
2c48f39d-2d7f-42fd-9487-176b11d00f46	gender	claim.name
2c48f39d-2d7f-42fd-9487-176b11d00f46	String	jsonType.label
2c9922ad-9df2-44ec-8623-20a112221dde	true	userinfo.token.claim
2c9922ad-9df2-44ec-8623-20a112221dde	website	user.attribute
2c9922ad-9df2-44ec-8623-20a112221dde	true	id.token.claim
2c9922ad-9df2-44ec-8623-20a112221dde	true	access.token.claim
2c9922ad-9df2-44ec-8623-20a112221dde	website	claim.name
2c9922ad-9df2-44ec-8623-20a112221dde	String	jsonType.label
35b685c0-dd96-4a20-b6eb-ef3e8f195e83	true	userinfo.token.claim
35b685c0-dd96-4a20-b6eb-ef3e8f195e83	firstName	user.attribute
35b685c0-dd96-4a20-b6eb-ef3e8f195e83	true	id.token.claim
35b685c0-dd96-4a20-b6eb-ef3e8f195e83	true	access.token.claim
35b685c0-dd96-4a20-b6eb-ef3e8f195e83	given_name	claim.name
35b685c0-dd96-4a20-b6eb-ef3e8f195e83	String	jsonType.label
35f1acd8-0071-4059-b9ef-89d9f7ecea5a	true	userinfo.token.claim
35f1acd8-0071-4059-b9ef-89d9f7ecea5a	locale	user.attribute
35f1acd8-0071-4059-b9ef-89d9f7ecea5a	true	id.token.claim
35f1acd8-0071-4059-b9ef-89d9f7ecea5a	true	access.token.claim
35f1acd8-0071-4059-b9ef-89d9f7ecea5a	locale	claim.name
35f1acd8-0071-4059-b9ef-89d9f7ecea5a	String	jsonType.label
446454ca-2301-45c3-9666-db97d11296f8	true	userinfo.token.claim
446454ca-2301-45c3-9666-db97d11296f8	updatedAt	user.attribute
446454ca-2301-45c3-9666-db97d11296f8	true	id.token.claim
446454ca-2301-45c3-9666-db97d11296f8	true	access.token.claim
446454ca-2301-45c3-9666-db97d11296f8	updated_at	claim.name
446454ca-2301-45c3-9666-db97d11296f8	long	jsonType.label
945cc86e-5dd6-41c9-b648-0be000deeade	true	userinfo.token.claim
945cc86e-5dd6-41c9-b648-0be000deeade	username	user.attribute
945cc86e-5dd6-41c9-b648-0be000deeade	true	id.token.claim
945cc86e-5dd6-41c9-b648-0be000deeade	true	access.token.claim
945cc86e-5dd6-41c9-b648-0be000deeade	preferred_username	claim.name
945cc86e-5dd6-41c9-b648-0be000deeade	String	jsonType.label
9ae8b7d2-51d8-447c-a2ad-b4150ec99d78	true	userinfo.token.claim
9ae8b7d2-51d8-447c-a2ad-b4150ec99d78	true	id.token.claim
9ae8b7d2-51d8-447c-a2ad-b4150ec99d78	true	access.token.claim
a19632b5-8984-4780-90c6-709d35887024	true	userinfo.token.claim
a19632b5-8984-4780-90c6-709d35887024	profile	user.attribute
a19632b5-8984-4780-90c6-709d35887024	true	id.token.claim
a19632b5-8984-4780-90c6-709d35887024	true	access.token.claim
a19632b5-8984-4780-90c6-709d35887024	profile	claim.name
a19632b5-8984-4780-90c6-709d35887024	String	jsonType.label
b32e74bc-dc43-4548-b9a7-781dad489bda	true	userinfo.token.claim
b32e74bc-dc43-4548-b9a7-781dad489bda	lastName	user.attribute
b32e74bc-dc43-4548-b9a7-781dad489bda	true	id.token.claim
b32e74bc-dc43-4548-b9a7-781dad489bda	true	access.token.claim
b32e74bc-dc43-4548-b9a7-781dad489bda	family_name	claim.name
b32e74bc-dc43-4548-b9a7-781dad489bda	String	jsonType.label
d78dcbaa-0b68-4cc2-8f96-f65c1ad926d7	true	userinfo.token.claim
d78dcbaa-0b68-4cc2-8f96-f65c1ad926d7	picture	user.attribute
d78dcbaa-0b68-4cc2-8f96-f65c1ad926d7	true	id.token.claim
d78dcbaa-0b68-4cc2-8f96-f65c1ad926d7	true	access.token.claim
d78dcbaa-0b68-4cc2-8f96-f65c1ad926d7	picture	claim.name
d78dcbaa-0b68-4cc2-8f96-f65c1ad926d7	String	jsonType.label
e857e2d5-64ae-406e-ac60-0bed2d68c2fd	true	userinfo.token.claim
e857e2d5-64ae-406e-ac60-0bed2d68c2fd	middleName	user.attribute
e857e2d5-64ae-406e-ac60-0bed2d68c2fd	true	id.token.claim
e857e2d5-64ae-406e-ac60-0bed2d68c2fd	true	access.token.claim
e857e2d5-64ae-406e-ac60-0bed2d68c2fd	middle_name	claim.name
e857e2d5-64ae-406e-ac60-0bed2d68c2fd	String	jsonType.label
eb2ca0f0-e429-4760-9b8b-b1e2410899bd	true	userinfo.token.claim
eb2ca0f0-e429-4760-9b8b-b1e2410899bd	nickname	user.attribute
eb2ca0f0-e429-4760-9b8b-b1e2410899bd	true	id.token.claim
eb2ca0f0-e429-4760-9b8b-b1e2410899bd	true	access.token.claim
eb2ca0f0-e429-4760-9b8b-b1e2410899bd	nickname	claim.name
eb2ca0f0-e429-4760-9b8b-b1e2410899bd	String	jsonType.label
7597afd8-a6eb-4ba0-8998-22a0e5996637	true	userinfo.token.claim
7597afd8-a6eb-4ba0-8998-22a0e5996637	emailVerified	user.attribute
7597afd8-a6eb-4ba0-8998-22a0e5996637	true	id.token.claim
7597afd8-a6eb-4ba0-8998-22a0e5996637	true	access.token.claim
7597afd8-a6eb-4ba0-8998-22a0e5996637	email_verified	claim.name
7597afd8-a6eb-4ba0-8998-22a0e5996637	boolean	jsonType.label
891ef29f-a0d2-4c0c-a706-1230804cf8b9	true	userinfo.token.claim
891ef29f-a0d2-4c0c-a706-1230804cf8b9	email	user.attribute
891ef29f-a0d2-4c0c-a706-1230804cf8b9	true	id.token.claim
891ef29f-a0d2-4c0c-a706-1230804cf8b9	true	access.token.claim
891ef29f-a0d2-4c0c-a706-1230804cf8b9	email	claim.name
891ef29f-a0d2-4c0c-a706-1230804cf8b9	String	jsonType.label
3b4e0a6b-019c-4662-a141-68097980a2a2	formatted	user.attribute.formatted
3b4e0a6b-019c-4662-a141-68097980a2a2	country	user.attribute.country
3b4e0a6b-019c-4662-a141-68097980a2a2	postal_code	user.attribute.postal_code
3b4e0a6b-019c-4662-a141-68097980a2a2	true	userinfo.token.claim
3b4e0a6b-019c-4662-a141-68097980a2a2	street	user.attribute.street
3b4e0a6b-019c-4662-a141-68097980a2a2	true	id.token.claim
3b4e0a6b-019c-4662-a141-68097980a2a2	region	user.attribute.region
3b4e0a6b-019c-4662-a141-68097980a2a2	true	access.token.claim
3b4e0a6b-019c-4662-a141-68097980a2a2	locality	user.attribute.locality
0a558f83-9165-4103-abfe-03493a26b600	true	userinfo.token.claim
0a558f83-9165-4103-abfe-03493a26b600	phoneNumber	user.attribute
0a558f83-9165-4103-abfe-03493a26b600	true	id.token.claim
0a558f83-9165-4103-abfe-03493a26b600	true	access.token.claim
0a558f83-9165-4103-abfe-03493a26b600	phone_number	claim.name
0a558f83-9165-4103-abfe-03493a26b600	String	jsonType.label
65edf2f4-3f17-4c3f-8796-7cc0429751ed	true	userinfo.token.claim
65edf2f4-3f17-4c3f-8796-7cc0429751ed	phoneNumberVerified	user.attribute
65edf2f4-3f17-4c3f-8796-7cc0429751ed	true	id.token.claim
65edf2f4-3f17-4c3f-8796-7cc0429751ed	true	access.token.claim
65edf2f4-3f17-4c3f-8796-7cc0429751ed	phone_number_verified	claim.name
65edf2f4-3f17-4c3f-8796-7cc0429751ed	boolean	jsonType.label
17144bc5-caa7-4842-9a60-ca5ff951e5c2	true	multivalued
17144bc5-caa7-4842-9a60-ca5ff951e5c2	foo	user.attribute
17144bc5-caa7-4842-9a60-ca5ff951e5c2	true	access.token.claim
17144bc5-caa7-4842-9a60-ca5ff951e5c2	realm_access.roles	claim.name
17144bc5-caa7-4842-9a60-ca5ff951e5c2	String	jsonType.label
7d3addfb-c089-4b67-a7a1-5364ba9c9f75	true	multivalued
7d3addfb-c089-4b67-a7a1-5364ba9c9f75	foo	user.attribute
7d3addfb-c089-4b67-a7a1-5364ba9c9f75	true	access.token.claim
7d3addfb-c089-4b67-a7a1-5364ba9c9f75	resource_access.${client_id}.roles	claim.name
7d3addfb-c089-4b67-a7a1-5364ba9c9f75	String	jsonType.label
15d2fdea-fb4b-457a-aaf1-ba1b69b1ad75	true	multivalued
15d2fdea-fb4b-457a-aaf1-ba1b69b1ad75	foo	user.attribute
15d2fdea-fb4b-457a-aaf1-ba1b69b1ad75	true	id.token.claim
15d2fdea-fb4b-457a-aaf1-ba1b69b1ad75	true	access.token.claim
15d2fdea-fb4b-457a-aaf1-ba1b69b1ad75	groups	claim.name
15d2fdea-fb4b-457a-aaf1-ba1b69b1ad75	String	jsonType.label
f7b9ab49-8655-4a0b-b146-f9a50ae8faac	true	userinfo.token.claim
f7b9ab49-8655-4a0b-b146-f9a50ae8faac	username	user.attribute
f7b9ab49-8655-4a0b-b146-f9a50ae8faac	true	id.token.claim
f7b9ab49-8655-4a0b-b146-f9a50ae8faac	true	access.token.claim
f7b9ab49-8655-4a0b-b146-f9a50ae8faac	upn	claim.name
f7b9ab49-8655-4a0b-b146-f9a50ae8faac	String	jsonType.label
414d723d-bb5b-4a3b-8e31-110657383148	true	id.token.claim
414d723d-bb5b-4a3b-8e31-110657383148	true	access.token.claim
dee6dae6-5b20-490a-a7d8-f864aa4b4aad	false	single
dee6dae6-5b20-490a-a7d8-f864aa4b4aad	Basic	attribute.nameformat
dee6dae6-5b20-490a-a7d8-f864aa4b4aad	Role	attribute.name
184b2689-51ac-4fac-9d4b-ef269b78eb19	true	userinfo.token.claim
184b2689-51ac-4fac-9d4b-ef269b78eb19	lastName	user.attribute
184b2689-51ac-4fac-9d4b-ef269b78eb19	true	id.token.claim
184b2689-51ac-4fac-9d4b-ef269b78eb19	true	access.token.claim
184b2689-51ac-4fac-9d4b-ef269b78eb19	family_name	claim.name
184b2689-51ac-4fac-9d4b-ef269b78eb19	String	jsonType.label
2677b031-e47a-449f-be04-46d5feafeee6	true	userinfo.token.claim
2677b031-e47a-449f-be04-46d5feafeee6	birthdate	user.attribute
2677b031-e47a-449f-be04-46d5feafeee6	true	id.token.claim
2677b031-e47a-449f-be04-46d5feafeee6	true	access.token.claim
2677b031-e47a-449f-be04-46d5feafeee6	birthdate	claim.name
2677b031-e47a-449f-be04-46d5feafeee6	String	jsonType.label
32f78f1f-7082-44bc-8d2b-204889acd978	true	userinfo.token.claim
32f78f1f-7082-44bc-8d2b-204889acd978	middleName	user.attribute
32f78f1f-7082-44bc-8d2b-204889acd978	true	id.token.claim
32f78f1f-7082-44bc-8d2b-204889acd978	true	access.token.claim
32f78f1f-7082-44bc-8d2b-204889acd978	middle_name	claim.name
32f78f1f-7082-44bc-8d2b-204889acd978	String	jsonType.label
780268b1-d2f3-4f4c-bb0f-40aaba749499	true	userinfo.token.claim
780268b1-d2f3-4f4c-bb0f-40aaba749499	website	user.attribute
780268b1-d2f3-4f4c-bb0f-40aaba749499	true	id.token.claim
780268b1-d2f3-4f4c-bb0f-40aaba749499	true	access.token.claim
780268b1-d2f3-4f4c-bb0f-40aaba749499	website	claim.name
780268b1-d2f3-4f4c-bb0f-40aaba749499	String	jsonType.label
7e8f8991-bf8e-447c-a9c8-2b476cacc19d	true	userinfo.token.claim
7e8f8991-bf8e-447c-a9c8-2b476cacc19d	profile	user.attribute
7e8f8991-bf8e-447c-a9c8-2b476cacc19d	true	id.token.claim
7e8f8991-bf8e-447c-a9c8-2b476cacc19d	true	access.token.claim
7e8f8991-bf8e-447c-a9c8-2b476cacc19d	profile	claim.name
7e8f8991-bf8e-447c-a9c8-2b476cacc19d	String	jsonType.label
82f716f9-c8ee-4fda-b573-9ffbe1d2f649	true	userinfo.token.claim
82f716f9-c8ee-4fda-b573-9ffbe1d2f649	firstName	user.attribute
82f716f9-c8ee-4fda-b573-9ffbe1d2f649	true	id.token.claim
82f716f9-c8ee-4fda-b573-9ffbe1d2f649	true	access.token.claim
82f716f9-c8ee-4fda-b573-9ffbe1d2f649	given_name	claim.name
82f716f9-c8ee-4fda-b573-9ffbe1d2f649	String	jsonType.label
87f19379-1fa7-4a43-80c8-9ff5a69a3342	true	userinfo.token.claim
87f19379-1fa7-4a43-80c8-9ff5a69a3342	updatedAt	user.attribute
87f19379-1fa7-4a43-80c8-9ff5a69a3342	true	id.token.claim
87f19379-1fa7-4a43-80c8-9ff5a69a3342	true	access.token.claim
87f19379-1fa7-4a43-80c8-9ff5a69a3342	updated_at	claim.name
87f19379-1fa7-4a43-80c8-9ff5a69a3342	long	jsonType.label
99781fed-fa5f-41ea-97c0-0290c7d5dbcb	true	userinfo.token.claim
99781fed-fa5f-41ea-97c0-0290c7d5dbcb	gender	user.attribute
99781fed-fa5f-41ea-97c0-0290c7d5dbcb	true	id.token.claim
99781fed-fa5f-41ea-97c0-0290c7d5dbcb	true	access.token.claim
99781fed-fa5f-41ea-97c0-0290c7d5dbcb	gender	claim.name
99781fed-fa5f-41ea-97c0-0290c7d5dbcb	String	jsonType.label
aecbdab6-7e0b-4dea-9295-a6992e7b1ebe	true	userinfo.token.claim
aecbdab6-7e0b-4dea-9295-a6992e7b1ebe	picture	user.attribute
aecbdab6-7e0b-4dea-9295-a6992e7b1ebe	true	id.token.claim
aecbdab6-7e0b-4dea-9295-a6992e7b1ebe	true	access.token.claim
aecbdab6-7e0b-4dea-9295-a6992e7b1ebe	picture	claim.name
aecbdab6-7e0b-4dea-9295-a6992e7b1ebe	String	jsonType.label
b6678e6f-466a-4c2b-996b-0d4f5f68f08f	true	userinfo.token.claim
b6678e6f-466a-4c2b-996b-0d4f5f68f08f	locale	user.attribute
b6678e6f-466a-4c2b-996b-0d4f5f68f08f	true	id.token.claim
b6678e6f-466a-4c2b-996b-0d4f5f68f08f	true	access.token.claim
b6678e6f-466a-4c2b-996b-0d4f5f68f08f	locale	claim.name
b6678e6f-466a-4c2b-996b-0d4f5f68f08f	String	jsonType.label
c00e620f-ddf1-4b1a-b2e2-4eb522c48113	true	userinfo.token.claim
c00e620f-ddf1-4b1a-b2e2-4eb522c48113	username	user.attribute
c00e620f-ddf1-4b1a-b2e2-4eb522c48113	true	id.token.claim
c00e620f-ddf1-4b1a-b2e2-4eb522c48113	true	access.token.claim
c00e620f-ddf1-4b1a-b2e2-4eb522c48113	preferred_username	claim.name
c00e620f-ddf1-4b1a-b2e2-4eb522c48113	String	jsonType.label
f3a0ef13-078e-4da3-8899-9668c64f524b	true	userinfo.token.claim
f3a0ef13-078e-4da3-8899-9668c64f524b	zoneinfo	user.attribute
f3a0ef13-078e-4da3-8899-9668c64f524b	true	id.token.claim
f3a0ef13-078e-4da3-8899-9668c64f524b	true	access.token.claim
f3a0ef13-078e-4da3-8899-9668c64f524b	zoneinfo	claim.name
f3a0ef13-078e-4da3-8899-9668c64f524b	String	jsonType.label
f9aa8ca8-f5c6-479e-b4ca-2a49709b9d1d	true	userinfo.token.claim
f9aa8ca8-f5c6-479e-b4ca-2a49709b9d1d	nickname	user.attribute
f9aa8ca8-f5c6-479e-b4ca-2a49709b9d1d	true	id.token.claim
f9aa8ca8-f5c6-479e-b4ca-2a49709b9d1d	true	access.token.claim
f9aa8ca8-f5c6-479e-b4ca-2a49709b9d1d	nickname	claim.name
f9aa8ca8-f5c6-479e-b4ca-2a49709b9d1d	String	jsonType.label
fe154a93-9494-4a4b-a105-8ef56247e76a	true	userinfo.token.claim
fe154a93-9494-4a4b-a105-8ef56247e76a	true	id.token.claim
fe154a93-9494-4a4b-a105-8ef56247e76a	true	access.token.claim
2de01c71-7e6d-4ad8-a52b-db9357641b3e	true	userinfo.token.claim
2de01c71-7e6d-4ad8-a52b-db9357641b3e	email	user.attribute
2de01c71-7e6d-4ad8-a52b-db9357641b3e	true	id.token.claim
2de01c71-7e6d-4ad8-a52b-db9357641b3e	true	access.token.claim
2de01c71-7e6d-4ad8-a52b-db9357641b3e	email	claim.name
2de01c71-7e6d-4ad8-a52b-db9357641b3e	String	jsonType.label
c940674c-28a4-4908-bcb4-722ddbb7b8c0	true	userinfo.token.claim
c940674c-28a4-4908-bcb4-722ddbb7b8c0	emailVerified	user.attribute
c940674c-28a4-4908-bcb4-722ddbb7b8c0	true	id.token.claim
c940674c-28a4-4908-bcb4-722ddbb7b8c0	true	access.token.claim
c940674c-28a4-4908-bcb4-722ddbb7b8c0	email_verified	claim.name
c940674c-28a4-4908-bcb4-722ddbb7b8c0	boolean	jsonType.label
1717a35e-552d-41f6-b179-028a6ef738a8	formatted	user.attribute.formatted
1717a35e-552d-41f6-b179-028a6ef738a8	country	user.attribute.country
1717a35e-552d-41f6-b179-028a6ef738a8	postal_code	user.attribute.postal_code
1717a35e-552d-41f6-b179-028a6ef738a8	true	userinfo.token.claim
1717a35e-552d-41f6-b179-028a6ef738a8	street	user.attribute.street
1717a35e-552d-41f6-b179-028a6ef738a8	true	id.token.claim
1717a35e-552d-41f6-b179-028a6ef738a8	region	user.attribute.region
1717a35e-552d-41f6-b179-028a6ef738a8	true	access.token.claim
1717a35e-552d-41f6-b179-028a6ef738a8	locality	user.attribute.locality
5ba50ef8-48b5-4a9d-936e-f3eeaa38bafc	true	userinfo.token.claim
5ba50ef8-48b5-4a9d-936e-f3eeaa38bafc	phoneNumberVerified	user.attribute
5ba50ef8-48b5-4a9d-936e-f3eeaa38bafc	true	id.token.claim
5ba50ef8-48b5-4a9d-936e-f3eeaa38bafc	true	access.token.claim
5ba50ef8-48b5-4a9d-936e-f3eeaa38bafc	phone_number_verified	claim.name
5ba50ef8-48b5-4a9d-936e-f3eeaa38bafc	boolean	jsonType.label
eb40a6bd-ce70-41e5-b968-0deed7de455b	true	userinfo.token.claim
eb40a6bd-ce70-41e5-b968-0deed7de455b	phoneNumber	user.attribute
eb40a6bd-ce70-41e5-b968-0deed7de455b	true	id.token.claim
eb40a6bd-ce70-41e5-b968-0deed7de455b	true	access.token.claim
eb40a6bd-ce70-41e5-b968-0deed7de455b	phone_number	claim.name
eb40a6bd-ce70-41e5-b968-0deed7de455b	String	jsonType.label
2131af9e-0b2e-47f2-bcd5-05f46425405e	true	multivalued
2131af9e-0b2e-47f2-bcd5-05f46425405e	foo	user.attribute
2131af9e-0b2e-47f2-bcd5-05f46425405e	true	access.token.claim
2131af9e-0b2e-47f2-bcd5-05f46425405e	resource_access.${client_id}.roles	claim.name
2131af9e-0b2e-47f2-bcd5-05f46425405e	String	jsonType.label
9939a2dc-c7c7-4d67-82eb-b323717a260a	true	multivalued
9939a2dc-c7c7-4d67-82eb-b323717a260a	foo	user.attribute
9939a2dc-c7c7-4d67-82eb-b323717a260a	true	access.token.claim
9939a2dc-c7c7-4d67-82eb-b323717a260a	realm_access.roles	claim.name
9939a2dc-c7c7-4d67-82eb-b323717a260a	String	jsonType.label
38dfdc5f-2203-4428-bcf3-a244839254be	true	multivalued
38dfdc5f-2203-4428-bcf3-a244839254be	foo	user.attribute
38dfdc5f-2203-4428-bcf3-a244839254be	true	id.token.claim
38dfdc5f-2203-4428-bcf3-a244839254be	true	access.token.claim
38dfdc5f-2203-4428-bcf3-a244839254be	groups	claim.name
38dfdc5f-2203-4428-bcf3-a244839254be	String	jsonType.label
6f251cd6-ba85-4fe1-b594-64f601a63265	true	userinfo.token.claim
6f251cd6-ba85-4fe1-b594-64f601a63265	username	user.attribute
6f251cd6-ba85-4fe1-b594-64f601a63265	true	id.token.claim
6f251cd6-ba85-4fe1-b594-64f601a63265	true	access.token.claim
6f251cd6-ba85-4fe1-b594-64f601a63265	upn	claim.name
6f251cd6-ba85-4fe1-b594-64f601a63265	String	jsonType.label
545ad078-c429-4a1f-9ef0-b78ceb1a7b23	true	id.token.claim
545ad078-c429-4a1f-9ef0-b78ceb1a7b23	true	access.token.claim
2f1a4e9b-c3b5-413a-a6c6-cecb5c85e407	true	userinfo.token.claim
2f1a4e9b-c3b5-413a-a6c6-cecb5c85e407	locale	user.attribute
2f1a4e9b-c3b5-413a-a6c6-cecb5c85e407	true	id.token.claim
2f1a4e9b-c3b5-413a-a6c6-cecb5c85e407	true	access.token.claim
2f1a4e9b-c3b5-413a-a6c6-cecb5c85e407	locale	claim.name
2f1a4e9b-c3b5-413a-a6c6-cecb5c85e407	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
33b59376-8366-4d43-a008-09a699620c97	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	cff74c4b-1854-433b-b119-9374fd36bb06	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	659777c4-82cb-4878-be28-fb0491bba93b	9bfe34ac-50df-4270-8ed3-a0ae515180eb	8726cd1f-425f-418a-a0f7-8e49f348f56d	86c5f6f9-5fc5-407e-b8c1-8dc5e0e771bd	31ad81ae-d119-4f7b-b7a4-1145880284b6	2592000	f	900	t	f	d601f4d9-4508-41e8-ac39-ef4eca1422ea	0	f	0	0	4cdb3271-40fa-4ade-9a96-8fc23dee94a0
c17fc45e-3905-44c8-b28e-8ee1efd0c910	60	300	300	\N	\N	\N	t	f	0	\N	b3_social	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	c2dbac8e-0fb4-465b-b60b-c50f1d350a49	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	ad0a5703-5c3f-4c8a-a46b-cfc7e8b9ca0f	f48ef93c-d7e6-4e34-b056-a499da242bb8	ba76f0bc-b114-4128-8d4b-af5b5a3664bc	2fda754d-45bf-41ea-a1bb-2b57c65dffd9	740c7149-abdf-4ea8-a19a-fd2a3e440af1	2592000	f	900	t	f	8e5fcb9b-71f4-4f53-ae66-ebbd0d2eb888	0	f	0	0	2b65f79c-3fc9-4bb6-a320-464e08df72eb
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	33b59376-8366-4d43-a008-09a699620c97	
_browser_header.xContentTypeOptions	33b59376-8366-4d43-a008-09a699620c97	nosniff
_browser_header.referrerPolicy	33b59376-8366-4d43-a008-09a699620c97	no-referrer
_browser_header.xRobotsTag	33b59376-8366-4d43-a008-09a699620c97	none
_browser_header.xFrameOptions	33b59376-8366-4d43-a008-09a699620c97	SAMEORIGIN
_browser_header.contentSecurityPolicy	33b59376-8366-4d43-a008-09a699620c97	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	33b59376-8366-4d43-a008-09a699620c97	1; mode=block
_browser_header.strictTransportSecurity	33b59376-8366-4d43-a008-09a699620c97	max-age=31536000; includeSubDomains
bruteForceProtected	33b59376-8366-4d43-a008-09a699620c97	false
permanentLockout	33b59376-8366-4d43-a008-09a699620c97	false
maxFailureWaitSeconds	33b59376-8366-4d43-a008-09a699620c97	900
minimumQuickLoginWaitSeconds	33b59376-8366-4d43-a008-09a699620c97	60
waitIncrementSeconds	33b59376-8366-4d43-a008-09a699620c97	60
quickLoginCheckMilliSeconds	33b59376-8366-4d43-a008-09a699620c97	1000
maxDeltaTimeSeconds	33b59376-8366-4d43-a008-09a699620c97	43200
failureFactor	33b59376-8366-4d43-a008-09a699620c97	30
realmReusableOtpCode	33b59376-8366-4d43-a008-09a699620c97	false
displayName	33b59376-8366-4d43-a008-09a699620c97	Keycloak
displayNameHtml	33b59376-8366-4d43-a008-09a699620c97	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	33b59376-8366-4d43-a008-09a699620c97	RS256
offlineSessionMaxLifespanEnabled	33b59376-8366-4d43-a008-09a699620c97	false
offlineSessionMaxLifespan	33b59376-8366-4d43-a008-09a699620c97	5184000
_browser_header.contentSecurityPolicyReportOnly	c17fc45e-3905-44c8-b28e-8ee1efd0c910	
_browser_header.xContentTypeOptions	c17fc45e-3905-44c8-b28e-8ee1efd0c910	nosniff
_browser_header.referrerPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	no-referrer
_browser_header.xRobotsTag	c17fc45e-3905-44c8-b28e-8ee1efd0c910	none
_browser_header.xFrameOptions	c17fc45e-3905-44c8-b28e-8ee1efd0c910	SAMEORIGIN
_browser_header.contentSecurityPolicy	c17fc45e-3905-44c8-b28e-8ee1efd0c910	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	c17fc45e-3905-44c8-b28e-8ee1efd0c910	1; mode=block
_browser_header.strictTransportSecurity	c17fc45e-3905-44c8-b28e-8ee1efd0c910	max-age=31536000; includeSubDomains
bruteForceProtected	c17fc45e-3905-44c8-b28e-8ee1efd0c910	false
permanentLockout	c17fc45e-3905-44c8-b28e-8ee1efd0c910	false
maxFailureWaitSeconds	c17fc45e-3905-44c8-b28e-8ee1efd0c910	900
minimumQuickLoginWaitSeconds	c17fc45e-3905-44c8-b28e-8ee1efd0c910	60
waitIncrementSeconds	c17fc45e-3905-44c8-b28e-8ee1efd0c910	60
quickLoginCheckMilliSeconds	c17fc45e-3905-44c8-b28e-8ee1efd0c910	1000
maxDeltaTimeSeconds	c17fc45e-3905-44c8-b28e-8ee1efd0c910	43200
failureFactor	c17fc45e-3905-44c8-b28e-8ee1efd0c910	30
realmReusableOtpCode	c17fc45e-3905-44c8-b28e-8ee1efd0c910	false
defaultSignatureAlgorithm	c17fc45e-3905-44c8-b28e-8ee1efd0c910	RS256
offlineSessionMaxLifespanEnabled	c17fc45e-3905-44c8-b28e-8ee1efd0c910	false
offlineSessionMaxLifespan	c17fc45e-3905-44c8-b28e-8ee1efd0c910	5184000
actionTokenGeneratedByAdminLifespan	c17fc45e-3905-44c8-b28e-8ee1efd0c910	43200
actionTokenGeneratedByUserLifespan	c17fc45e-3905-44c8-b28e-8ee1efd0c910	300
oauth2DeviceCodeLifespan	c17fc45e-3905-44c8-b28e-8ee1efd0c910	600
oauth2DevicePollingInterval	c17fc45e-3905-44c8-b28e-8ee1efd0c910	5
webAuthnPolicyRpEntityName	c17fc45e-3905-44c8-b28e-8ee1efd0c910	keycloak
webAuthnPolicySignatureAlgorithms	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ES256
webAuthnPolicyRpId	c17fc45e-3905-44c8-b28e-8ee1efd0c910	
webAuthnPolicyAttestationConveyancePreference	c17fc45e-3905-44c8-b28e-8ee1efd0c910	not specified
webAuthnPolicyAuthenticatorAttachment	c17fc45e-3905-44c8-b28e-8ee1efd0c910	not specified
webAuthnPolicyRequireResidentKey	c17fc45e-3905-44c8-b28e-8ee1efd0c910	not specified
webAuthnPolicyUserVerificationRequirement	c17fc45e-3905-44c8-b28e-8ee1efd0c910	not specified
webAuthnPolicyCreateTimeout	c17fc45e-3905-44c8-b28e-8ee1efd0c910	0
webAuthnPolicyAvoidSameAuthenticatorRegister	c17fc45e-3905-44c8-b28e-8ee1efd0c910	false
webAuthnPolicyRpEntityNamePasswordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	ES256
webAuthnPolicyRpIdPasswordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	
webAuthnPolicyAttestationConveyancePreferencePasswordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	not specified
webAuthnPolicyRequireResidentKeyPasswordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	not specified
webAuthnPolicyCreateTimeoutPasswordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	false
cibaBackchannelTokenDeliveryMode	c17fc45e-3905-44c8-b28e-8ee1efd0c910	poll
cibaExpiresIn	c17fc45e-3905-44c8-b28e-8ee1efd0c910	120
cibaInterval	c17fc45e-3905-44c8-b28e-8ee1efd0c910	5
cibaAuthRequestedUserHint	c17fc45e-3905-44c8-b28e-8ee1efd0c910	login_hint
parRequestUriLifespan	c17fc45e-3905-44c8-b28e-8ee1efd0c910	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
33b59376-8366-4d43-a008-09a699620c97	jboss-logging
c17fc45e-3905-44c8-b28e-8ee1efd0c910	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	33b59376-8366-4d43-a008-09a699620c97
password	password	t	t	c17fc45e-3905-44c8-b28e-8ee1efd0c910
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.redirect_uris (client_id, value) FROM stdin;
be31244a-8352-4068-a494-0611b28f8a6d	/realms/master/account/*
5a298aed-16ad-443c-97bc-7c0484fa2768	/realms/master/account/*
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	/admin/master/console/*
a83e9c3b-8e0c-4a67-b5fb-a5c47ff93f2a	/realms/b3_social/account/*
2c734bda-b684-4c63-becb-d9c862a36bfb	/realms/b3_social/account/*
39dc6190-8591-442b-ad84-94882ffbbf34	/admin/b3_social/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
6f03fab2-2dda-4c65-80f7-96339998801e	VERIFY_EMAIL	Verify Email	33b59376-8366-4d43-a008-09a699620c97	t	f	VERIFY_EMAIL	50
90843f4d-321e-40ce-8726-fff574a8f3ee	UPDATE_PROFILE	Update Profile	33b59376-8366-4d43-a008-09a699620c97	t	f	UPDATE_PROFILE	40
57a72d83-ce49-420d-a7bb-94ce74c92769	CONFIGURE_TOTP	Configure OTP	33b59376-8366-4d43-a008-09a699620c97	t	f	CONFIGURE_TOTP	10
9796d651-7dd4-4727-83ae-5526f4f07d9e	UPDATE_PASSWORD	Update Password	33b59376-8366-4d43-a008-09a699620c97	t	f	UPDATE_PASSWORD	30
a6b868fb-ab40-4073-9c28-30300d9dcf08	TERMS_AND_CONDITIONS	Terms and Conditions	33b59376-8366-4d43-a008-09a699620c97	f	f	TERMS_AND_CONDITIONS	20
54875d17-bdba-4544-bca3-0574624c37db	delete_account	Delete Account	33b59376-8366-4d43-a008-09a699620c97	f	f	delete_account	60
88297f52-0cb0-42e2-97f2-45c149874384	update_user_locale	Update User Locale	33b59376-8366-4d43-a008-09a699620c97	t	f	update_user_locale	1000
349b832c-5ca5-460d-b821-f45cf191c2c9	webauthn-register	Webauthn Register	33b59376-8366-4d43-a008-09a699620c97	t	f	webauthn-register	70
f06aebed-115b-43b2-a44b-dff81e5a5f36	webauthn-register-passwordless	Webauthn Register Passwordless	33b59376-8366-4d43-a008-09a699620c97	t	f	webauthn-register-passwordless	80
c0928f27-7bcc-4c76-8563-5dc4d70d10c6	VERIFY_EMAIL	Verify Email	c17fc45e-3905-44c8-b28e-8ee1efd0c910	t	f	VERIFY_EMAIL	50
fc79b387-9d8a-442b-bfe8-650cabb11e1a	UPDATE_PROFILE	Update Profile	c17fc45e-3905-44c8-b28e-8ee1efd0c910	t	f	UPDATE_PROFILE	40
8b268d20-4c86-47d0-97fc-da24a99fb199	CONFIGURE_TOTP	Configure OTP	c17fc45e-3905-44c8-b28e-8ee1efd0c910	t	f	CONFIGURE_TOTP	10
3ba591b3-e293-4d1b-b50d-43a88def16b2	UPDATE_PASSWORD	Update Password	c17fc45e-3905-44c8-b28e-8ee1efd0c910	t	f	UPDATE_PASSWORD	30
12e1d1e1-45f9-4484-8c7f-b052d0707653	TERMS_AND_CONDITIONS	Terms and Conditions	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f	f	TERMS_AND_CONDITIONS	20
552184f2-6c43-4102-9443-9f1feaebede3	delete_account	Delete Account	c17fc45e-3905-44c8-b28e-8ee1efd0c910	f	f	delete_account	60
944544ea-14ad-4704-9306-824f3475661f	update_user_locale	Update User Locale	c17fc45e-3905-44c8-b28e-8ee1efd0c910	t	f	update_user_locale	1000
5fba7b45-d79b-4bde-9b5a-4922bdf45c2c	webauthn-register	Webauthn Register	c17fc45e-3905-44c8-b28e-8ee1efd0c910	t	f	webauthn-register	70
e2837f09-f78f-4abc-9e68-9d1f6fa02ae4	webauthn-register-passwordless	Webauthn Register Passwordless	c17fc45e-3905-44c8-b28e-8ee1efd0c910	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
5a298aed-16ad-443c-97bc-7c0484fa2768	ff9f7680-e5c4-4516-8acf-004efe2036e6
5a298aed-16ad-443c-97bc-7c0484fa2768	3a46b9fe-ad0c-4ceb-be9c-820527bf3bdf
2c734bda-b684-4c63-becb-d9c862a36bfb	a0db6382-1486-4374-862f-bbb2ce5f2e2b
2c734bda-b684-4c63-becb-d9c862a36bfb	6da4449a-e616-4f00-b7cc-345b996b5130
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
1f96089b-9c8a-4efa-aab9-84f1db2c61bf	\N	611d6bc3-0a4f-45c4-9049-f0b5c8edd7df	f	t	\N	\N	\N	33b59376-8366-4d43-a008-09a699620c97	admin	1695072054753	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
4cdb3271-40fa-4ade-9a96-8fc23dee94a0	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
fbfa750c-7647-4280-a345-71b47a95830b	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
9f86ec7c-c3f5-49a4-97f0-8094c00be467	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
a6a30443-ce48-4df1-b7bb-1e7ec9d0ff8d	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
1fd9ad50-e285-4f65-88c1-03649462e61e	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
62f30aaa-7b3c-4afa-b463-e982d90d0f37	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
62198104-c5f6-45a3-88df-0591b1187e5d	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
9d04bd3f-015b-4e59-b103-3f89e92340f3	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
45c81686-6e8e-40d9-9a18-aea1d438c325	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
c1ab0c95-1843-4e8b-b29e-052430e10657	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
a0a803ff-a3fd-4fed-96ee-79ad451c6c29	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
75b02cd1-f8e0-4280-bd18-cefeb0ffb7c0	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
c047a023-29b0-4a2c-bf96-07ce3c37a013	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
a1b3eb85-f471-4ec5-8f6b-751db874d920	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
f7572420-3328-4489-8c62-9832d4ce798f	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
7e4e11e3-1638-4d1c-98b7-b20974b461ff	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
a0137cc9-4b0c-4041-a28e-43bc4fcc69ca	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
4d7f1eb0-627e-41f2-9f72-842f925fc13b	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
73a6849b-46a8-4355-ba9a-e2570f1a6f34	1f96089b-9c8a-4efa-aab9-84f1db2c61bf
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.web_origins (client_id, value) FROM stdin;
7ed4df18-db1c-4d6e-88c4-1def9a22f6c6	+
39dc6190-8591-442b-ad84-94882ffbbf34	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

