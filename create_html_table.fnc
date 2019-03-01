create or replace function create_html_table(sql_in varchar2,
                                               table_width_prc number,
                                               head_bg_col varchar2 default '#FFFFFF',
                                               text_head_col varchar2 default 'black')
  return varchar2  is

  ----------------------------------------------------------------------------
  -----------------------------------------------------
  --function for creation of html tables from sql string
  --in params:
  --1) sql_in -- sql query string
  --2) table_width_prc -- width of html table in %
  --3) head_bg_col -- background colour in header, default '#FFFFFF' (white)
  --4) text_head_col -- colour of text in header, default 'black'
  ----------------------------------------------------------------------------
  -----------------------------------------------------
    --dbms_sql variables
    v_cursor_id integer;
    v_col_cnt integer;
    v_columns dbms_sql.desc_tab;
    -------------------------
    CurCol varchar2(32000);
    CurSQL varchar2(32000);
    TYPE t_mail_col_names IS TABLE OF VARCHAR2(500);
    col_names t_mail_col_names := t_mail_col_names();
    -----------------------------------------------
    CurHeaderAndCSS varchar2(32000);
    CurHtmlTable varchar2(32000);
    CurMessage varchar2(32000);
    CurHtmlTable_header varchar2(32000);
  begin
    v_cursor_id := dbms_sql.open_cursor;
    dbms_sql.parse(v_cursor_id, sql_in, dbms_sql.native);
    dbms_sql.describe_columns(v_cursor_id, v_col_cnt, v_columns);
    --CSS params for html table
    CurHeaderAndCSS := '<!DOCTYPE html>
                        <html>
                        <head>
                        <style>
                        table {
                          border-collapse: collapse;
                          width: '||table_width_prc||'%;
                          border: 1px solid #ddd;
                        }
                        td {
                          text-align: center;
                          padding: 8px;
                          border: 1px solid #ddd;
                        }
                        th {
                          text-align: center;
                          padding: 8px;
                          background-color: '||head_bg_col||';
                          color: '||text_head_col||';
                          border: 1px solid #ddd;
                        }
                        </style>
                        </head>';
    CurCol := '';
    --loop through columns to get column names
    for i in 1 .. v_columns.count loop
      CurCol := ltrim(CurCol || '","' || v_columns(i).col_name, '","');
      col_names.extend();
      col_names(i) := v_columns(i).col_name;
    end loop;
    --get data from sql query
    CurCol := replace(ltrim('"'||CurCol||'"',','), ',','||''</td><td>''||');
    CurSQL := 'select''<tr><td>''||(listagg('||CurCol||',''</td></tr><tr><td>'') within group(order by rownum))||''</td></tr>'' from ('||sql_in||')';
    --debug
    --dbms_output.put_line(CurSQL);
    execute immediate CurSQL into CurHtmlTable;

    --create table
    CurHtmlTable_header := '<table>';
    for i in col_names.first..col_names.last loop
      CurHtmlTable_header := CurHtmlTable_header ||'<th>'||col_names(i)||'</th>';
    end loop;

    CurMessage :=CurHeaderAndCSS || '<body> ' || CurHtmlTable_header || CurHtmlTable || '</table> </body> </html>';

    DBMS_SQL.close_cursor(v_cursor_id);

    return CurMessage;

  end;
/
