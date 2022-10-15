drop function if exists get_season();
create or replace function get_season(month_number int) returns text as
$$
declare
    season text;
begin
    if month_number not between 1 and 12 then
        raise notice 'Invalid month. You passed: %', month_number using hint = 'Allowed from 1 up to 12', errcode = 12888;
    end if;
    if month_number between 3 and 5 then
        season = 'Spring';
    elsif month_number between 6 and 8 then
        season = 'Summer';
    elsif month_number between 9 and 11 then
        season = 'Autumn';
    else
        season = 'Winter';
    end if;
    return season;
end;
$$ language plpgsql;
--
select get_season(14);
--
create or replace function get_season_called(month_number int) returns text as $$
begin
    return get_season(month_number);
exception when sqlstate '12888' then
    raise info 'A problem. Nothing special.';
    return null;
end;
$$ language plpgsql;

select get_season_called(15);