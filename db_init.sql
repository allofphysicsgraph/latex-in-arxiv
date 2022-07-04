
create schema api;
alter schema api owner to latexinarxiv;
create role web_anon nologin;
grant usage on schema api to web_anon;
create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator;

create table api.base (index int,filename text,checksum text,ts timestamp);

CREATE FUNCTION insert_timestamp()
RETURNS	TRIGGER AS $$
BEGIN
	NEW.ts := (select timestamp 'now');
	RETURN NEW;
END;
$$
LANGUAGE  plpgsql;

CREATE TRIGGER insert_timestamp_trigger
	BEFORE INSERT ON api.base
	FOR EACH ROW EXECUTE FUNCTION insert_timestamp();

CREATE TRIGGER insert_timestamp_trigger
	BEFORE INSERT ON api.abstract
	FOR EACH ROW EXECUTE FUNCTION insert_timestamp();

CREATE TRIGGER insert_timestamp_trigger
	BEFORE INSERT ON api.acknowledgments
	FOR EACH ROW EXECUTE FUNCTION insert_timestamp();

CREATE TRIGGER insert_timestamp_trigger
	BEFORE INSERT ON api.affiliation
	FOR EACH ROW EXECUTE FUNCTION insert_timestamp();

CREATE TRIGGER insert_timestamp_trigger
	BEFORE INSERT ON api.author
	FOR EACH ROW EXECUTE FUNCTION insert_timestamp();

CREATE TRIGGER insert_timestamp_trigger
	BEFORE INSERT ON api.cases
	FOR EACH ROW EXECUTE FUNCTION insert_timestamp();

CREATE TRIGGER insert_timestamp_trigger
	BEFORE INSERT ON api.cite
	FOR EACH ROW EXECUTE FUNCTION insert_timestamp();

CREATE TRIGGER insert_timestamp_trigger
	BEFORE INSERT ON api.definition
	FOR EACH ROW EXECUTE FUNCTION insert_timestamp();

CREATE TRIGGER insert_timestamp_trigger
	BEFORE INSERT ON api.description
	FOR EACH ROW EXECUTE FUNCTION insert_timestamp();

create table api.abstract (abstract text) INHERITS (api.base);
create table api.acknowledgments (acknowledgments text) INHERITS (api.base);
create table api.affiliation (affiliation text) INHERITS (api.base);
create table api.author (author text) INHERITS (api.base);
create table api.cases (cases text) INHERITS (api.base);
create table api.cite (cite text) INHERITS (api.base);
create table api.definition (definition text) INHERITS (api.base);
create table api.description (description text) INHERITS (api.base);
create table api.displaymath (displaymath text) INHERITS (api.base);
create table api.document (document text) INHERITS (api.base);
create table api.enumerate (enumerate text) INHERITS (api.base);
create table api.eq (eq text) INHERITS (api.base);
create table api.eqnarray (eqnarray text) INHERITS (api.base);
create table api.equation (equation text) INHERITS (api.base);
create table api.figure (figure text) INHERITS (api.base);
create table api.fractions (fractions text) INHERITS (api.base);
create table api.itemize (itemize text) INHERITS (api.base);
create table api.label (label text) INHERITS (api.base);
create table api.matrix (matrix text) INHERITS (api.base);
create table api.minipage (minipage text) INHERITS (api.base);
create table api.multline (multline text) INHERITS (api.base);
create table api.pacs (pacs text) INHERITS (api.base);
create table api.pmatrix (pmatrix text) INHERITS (api.base);
create table api.proof (proof text) INHERITS (api.base);
create table api.prop (prop text) INHERITS (api.base);
create table api.quote (quote text) INHERITS (api.base);
create table api.ref (ref text) INHERITS (api.base);
create table api.section (section text) INHERITS (api.base);
create table api.subequations (subequations text) INHERITS (api.base);
create table api.tabular (tabular text) INHERITS (api.base);
create table api.thebibliography (thebibliography text) INHERITS (api.base);
create table api.theorem (theorem text) INHERITS (api.base);
create table api.thm (thm text) INHERITS (api.base);
create table api.title (title text) INHERITS (api.base);
create table api.titlepage (titlepage text) INHERITS (api.base);
create table api.twomatrix (twomatrix text) INHERITS (api.base);
create table api.usepackage (usepackage text) INHERITS (api.base);


alter table api.abstract owner to latexinarxiv;
alter table api.acknowledgments owner to latexinarxiv;
alter table api.affiliation owner to latexinarxiv;
alter table api.author owner to latexinarxiv;
alter table api.cases owner to latexinarxiv;
alter table api.center owner to latexinarxiv;
alter table api.cite owner to latexinarxiv;
alter table api.definition owner to latexinarxiv;
alter table api.description owner to latexinarxiv;
alter table api.displaymath owner to latexinarxiv;
alter table api.document owner to latexinarxiv;
alter table api.enumerate owner to latexinarxiv;
alter table api.eq owner to latexinarxiv;
alter table api.eqnarray owner to latexinarxiv;
alter table api.equation owner to latexinarxiv;
alter table api.figure owner to latexinarxiv;
alter table api.flushleft owner to latexinarxiv;
alter table api.flushright owner to latexinarxiv;
alter table api.fractions owner to latexinarxiv;
alter table api.gather owner to latexinarxiv;
alter table api.itemize owner to latexinarxiv;
alter table api.label owner to latexinarxiv;
alter table api.matrix owner to latexinarxiv;
alter table api.minipage owner to latexinarxiv;
alter table api.multline owner to latexinarxiv;
alter table api.pacs owner to latexinarxiv;
alter table api.picture owner to latexinarxiv;
alter table api.pmatrix owner to latexinarxiv;
alter table api.proof owner to latexinarxiv;
alter table api.prop owner to latexinarxiv;
alter table api.quote owner to latexinarxiv;
alter table api.ref owner to latexinarxiv;
alter table api.section owner to latexinarxiv;
alter table api.small owner to latexinarxiv;
alter table api.split owner to latexinarxiv;
alter table api.subequations owner to latexinarxiv;
alter table api.tabular owner to latexinarxiv;
alter table api.thebibliography owner to latexinarxiv;
alter table api.theorem owner to latexinarxiv;
alter table api.thm owner to latexinarxiv;
alter table api.title owner to latexinarxiv;
alter table api.titlepage owner to latexinarxiv;
alter table api.twomatrix owner to latexinarxiv;
alter table api.usepackage owner to latexinarxiv;
alter table api.widetext owner to latexinarxiv;


grant select on api.abstract to web_anon;
grant select on api.acknowledgments to web_anon;
grant select on api.affiliation to web_anon;
grant select on api.author to web_anon;
grant select on api.cases to web_anon;
grant select on api.center to web_anon;
grant select on api.cite to web_anon;
grant select on api.definition to web_anon;
grant select on api.description to web_anon;
grant select on api.displaymath to web_anon;
grant select on api.document to web_anon;
grant select on api.enumerate to web_anon;
grant select on api.eq to web_anon;
grant select on api.eqnarray to web_anon;
grant select on api.equation to web_anon;
grant select on api.figure to web_anon;
grant select on api.flushleft to web_anon;
grant select on api.flushright to web_anon;
grant select on api.fractions to web_anon;
grant select on api.gather to web_anon;
grant select on api.itemize to web_anon;
grant select on api.label to web_anon;
grant select on api.matrix to web_anon;
grant select on api.minipage to web_anon;
grant select on api.multline to web_anon;
grant select on api.pacs to web_anon;
grant select on api.picture to web_anon;
grant select on api.pmatrix to web_anon;
grant select on api.proof to web_anon;
grant select on api.prop to web_anon;
grant select on api.quote to web_anon;
grant select on api.ref to web_anon;
grant select on api.section to web_anon;
grant select on api.small to web_anon;
grant select on api.split to web_anon;
grant select on api.subequations to web_anon;
grant select on api.tabular to web_anon;
grant select on api.thebibliography to web_anon;
grant select on api.theorem to web_anon;
grant select on api.thm to web_anon;
grant select on api.title to web_anon;
grant select on api.titlepage to web_anon;
grant select on api.twomatrix to web_anon;
grant select on api.usepackage to web_anon;
grant select on api.widetext to web_anon;
