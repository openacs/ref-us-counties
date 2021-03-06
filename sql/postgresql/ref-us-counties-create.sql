-- @author jon@jongriffin.com
-- @creation-date 2001-08-27
-- @cvs-id $Id$

-- This is the combination of state and county FIPS codes.
-- It is possible to get the state by parsing the first 2 chars

create table us_counties (
    fips_state_code  char(2)  
	             constraint us_counties_fips_fk
                     references us_states(fips_state_code),
    fips_county_code char(6)  
                     constraint us_counties_county_code_nn not null,
    name             varchar(100)
                     constraint us_counties_name_nn not null,
    state_abbrev     char(2)
                     constraint us_counties_state_abrrev_fk
                     references us_states(abbrev),
    population       numeric,
    housing_units    numeric,
    land_area        numeric,
    water_area       numeric,
    latitude         numeric,
    longitude        numeric,
    --
    -- Primary key for this table is generated by combining the state
    -- and county FIPS codes.  County code are only unique within a given state.
    -- 
    constraint us_counties_unique_fips_pk primary key (fips_county_code, fips_state_code)
);

comment on table us_counties is '
    This is the United States county code table from the US Census Bureau
';

comment on column us_counties.fips_state_code is '
State FIPS code.
';

comment on column us_counties.fips_county_code is '
County FIPS code.
';

comment on column us_counties.name is '
Name. Includes name of county. Counties don''t nave a type, but do have
the word "County" as part of the name.
';

comment on column us_counties.state_abbrev is '
State abbreviations.
';

comment on column us_counties.population is '
Total population (1990).
';

comment on column us_counties.housing_units is '
Housing units (1990).
';

comment on column us_counties.land_area is '
Land are included (in thousandths of a square kilometer).
';

comment on column us_counties.water_area is '
Water area included (in thousandths of a square kilometer).
';

comment on column us_counties.latitude is '
Longitude (millionths of a degree, + or - denoting N or S,
respectively.
';

comment on column us_counties.longitude is '
Latitude (millionths of a degree, + or - denoting N or S,
respectively.
';

-- add this table into the ACS reference repository

select acs_reference__new (
    'US_COUNTIES',
    '1990-12-31',
    'US Census Bureau',
    'http://ftp.census.gov/geo/www/gazetteer/places.html',
    now()
);
