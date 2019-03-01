# HTML table from SQL query string

in params:
1) sql_in -- sql query string
2) table_width_prc -- width of html table in %
3) head_bg_col -- background colour in header, default '#FFFFFF' (white)
4) text_head_col -- colour of text in header, default 'black'
output: html string 

Examples using hr schema: 



1)  White header, black text 

    select create_html_table(q'[select * 
    
                               from hr.employees 
                               
                               where rownum < 10]',30) from dual
2) White header, black text

   select create_html_table(q'[select first_name, hire_date from hr.employees 
   
                               where to_char(hire_date, 'YYYY') between 2002 and 2005 
                               
                               order by hire_date]',30) from dual

3) Blue header, white text

   select create_html_table(q'[select manager_id, count(*) 
   
                               from hr.employees 
                               
                               group by manager_id]', 30, '#D65A6', 'white') from dual

4) Green header, white text 

   select create_html_table(q'[select job_id, avg(salary) as "avg salary" 
   
                               from hr.employees 
                               
                               group by job_id 
                               
                               having avg(salary)>10000]', 30, '#27ae60', 'white') from dual


