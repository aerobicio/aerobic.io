--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE activities (
    id integer NOT NULL,
    user_id integer,
    type character varying(255),
    activity_workout_id integer,
    activity_user_id integer,
    activity_followed_user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activities_id_seq OWNED BY activities.id;


--
-- Name: authentications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    provider character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: fit_files; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fit_files (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    binary_data bytea NOT NULL,
    workout_id integer NOT NULL
);


--
-- Name: fit_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fit_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fit_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fit_files_id_seq OWNED BY fit_files.id;


--
-- Name: identities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE identities (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    password_digest character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: identities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE identities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE identities_id_seq OWNED BY identities.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: tcx_files; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tcx_files (
    id integer NOT NULL,
    workout_id integer NOT NULL,
    xml_data text NOT NULL
);


--
-- Name: tcx_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tcx_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tcx_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tcx_files_id_seq OWNED BY tcx_files.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_followings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_followings (
    id integer NOT NULL,
    user_id integer,
    following_id integer
);


--
-- Name: users_followings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_followings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_followings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_followings_id_seq OWNED BY users_followings.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: workouts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE workouts (
    id integer NOT NULL,
    active_duration integer NOT NULL,
    duration integer NOT NULL,
    distance integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer NOT NULL,
    device_workout_id character varying(255),
    device_id character varying(255),
    uuid character varying(255),
    sport character varying(255)
);


--
-- Name: workouts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE workouts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE workouts_id_seq OWNED BY workouts.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities ALTER COLUMN id SET DEFAULT nextval('activities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fit_files ALTER COLUMN id SET DEFAULT nextval('fit_files_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY identities ALTER COLUMN id SET DEFAULT nextval('identities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tcx_files ALTER COLUMN id SET DEFAULT nextval('tcx_files_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_followings ALTER COLUMN id SET DEFAULT nextval('users_followings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY workouts ALTER COLUMN id SET DEFAULT nextval('workouts_id_seq'::regclass);


--
-- Name: activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: fit_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fit_files
    ADD CONSTRAINT fit_files_pkey PRIMARY KEY (id);


--
-- Name: identities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: tcx_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tcx_files
    ADD CONSTRAINT tcx_files_pkey PRIMARY KEY (id);


--
-- Name: users_followings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users_followings
    ADD CONSTRAINT users_followings_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: workouts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY workouts
    ADD CONSTRAINT workouts_pkey PRIMARY KEY (id);


--
-- Name: index_activities_on_activity_followed_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_activity_followed_user_id ON activities USING btree (activity_followed_user_id);


--
-- Name: index_activities_on_activity_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_activity_user_id ON activities USING btree (activity_user_id);


--
-- Name: index_activities_on_activity_workout_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_activity_workout_id ON activities USING btree (activity_workout_id);


--
-- Name: index_activities_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_user_id ON activities USING btree (user_id);


--
-- Name: index_authentications_on_provider_and_uid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_authentications_on_provider_and_uid ON authentications USING btree (provider, uid);


--
-- Name: index_authentications_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_authentications_on_user_id ON authentications USING btree (user_id);


--
-- Name: index_fit_files_on_workout_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_fit_files_on_workout_id ON fit_files USING btree (workout_id);


--
-- Name: index_identities_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_identities_on_email ON identities USING btree (email);


--
-- Name: index_tcx_files_on_workout_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_tcx_files_on_workout_id ON tcx_files USING btree (workout_id);


--
-- Name: index_user_device_id_device_workout_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_user_device_id_device_workout_id ON workouts USING btree (user_id, device_id, device_workout_id);


--
-- Name: index_users_followings_on_following_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_followings_on_following_id ON users_followings USING btree (following_id);


--
-- Name: index_users_followings_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_followings_on_user_id ON users_followings USING btree (user_id);


--
-- Name: index_users_followings_on_user_id_and_following_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_followings_on_user_id_and_following_id ON users_followings USING btree (user_id, following_id);


--
-- Name: index_workouts_on_device_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_workouts_on_device_id ON workouts USING btree (device_id);


--
-- Name: index_workouts_on_device_workout_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_workouts_on_device_workout_id ON workouts USING btree (device_workout_id);


--
-- Name: index_workouts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_workouts_on_user_id ON workouts USING btree (user_id);


--
-- Name: index_workouts_on_uuid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_workouts_on_uuid ON workouts USING btree (uuid);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: activities_activity_followed_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_activity_followed_user_id_fk FOREIGN KEY (activity_followed_user_id) REFERENCES users(id);


--
-- Name: activities_activity_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_activity_user_id_fk FOREIGN KEY (activity_user_id) REFERENCES users(id);


--
-- Name: activities_activity_workout_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_activity_workout_id_fk FOREIGN KEY (activity_workout_id) REFERENCES workouts(id);


--
-- Name: activities_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: authentications_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fit_files_workout_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fit_files
    ADD CONSTRAINT fit_files_workout_id_fk FOREIGN KEY (workout_id) REFERENCES workouts(id);


--
-- Name: tcx_files_workout_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tcx_files
    ADD CONSTRAINT tcx_files_workout_id_fk FOREIGN KEY (workout_id) REFERENCES workouts(id);


--
-- Name: users_followings_following_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_followings
    ADD CONSTRAINT users_followings_following_id_fk FOREIGN KEY (following_id) REFERENCES users(id);


--
-- Name: users_followings_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_followings
    ADD CONSTRAINT users_followings_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: workouts_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY workouts
    ADD CONSTRAINT workouts_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130623051638');

INSERT INTO schema_migrations (version) VALUES ('20130717021104');

INSERT INTO schema_migrations (version) VALUES ('20130717044050');

INSERT INTO schema_migrations (version) VALUES ('20130717044144');

INSERT INTO schema_migrations (version) VALUES ('20130719044245');

INSERT INTO schema_migrations (version) VALUES ('20130719044915');

INSERT INTO schema_migrations (version) VALUES ('20130721071632');

INSERT INTO schema_migrations (version) VALUES ('20131002105909');

INSERT INTO schema_migrations (version) VALUES ('20131105002928');

INSERT INTO schema_migrations (version) VALUES ('20131116015612');

INSERT INTO schema_migrations (version) VALUES ('20131209080642');

INSERT INTO schema_migrations (version) VALUES ('20131222225330');

INSERT INTO schema_migrations (version) VALUES ('20131222225612');

INSERT INTO schema_migrations (version) VALUES ('20131229035452');

INSERT INTO schema_migrations (version) VALUES ('20140102110634');

INSERT INTO schema_migrations (version) VALUES ('20140106061052');

INSERT INTO schema_migrations (version) VALUES ('20140423051358');
