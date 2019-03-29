# HTML table from SQL query string

in params:
1) sql_in -- sql query string
2) table_width_prc -- width of html table in %
3) head_bg_col -- background colour in header, default '#FFFFFF' (white)
4) text_head_col -- colour of text in header, default 'black'
output: html string 

Examples using hr schema: 



1)  White header, black text
    ```sql
    select create_html_table(q'[select * 
                               from hr.employees 
                               where rownum < 10]',30) from dual
    ```
    ![1](https://user-images.githubusercontent.com/46852371/53679355-d2494680-3cdc-11e9-9c62-9d1e5e7e6b0c.jpg)

2) White header, black text
    ```sql
   select create_html_table(q'[select first_name, hire_date from hr.employees 
                               where to_char(hire_date, 'YYYY') between 2002 and 2005 
                               order by hire_date]',30) from dual
    ```
    <!---![2](https://user-images.githubusercontent.com/46852371/53679400-50a5e880-3cdd-11e9-99bb-6831ee579eee.jpg)-->
    ![2](https://user-images.githubusercontent.com/46852371/55232439-9f8c6280-5236-11e9-9d4d-c8386bfe1985.jpg)
3) Blue header, white text
   ```sql
   select create_html_table(q'[select manager_id, count(*) 
                               from hr.employees 
                               group by manager_id]', 30, '#4285E1', 'white') from dual
    ```
    ![3](https://user-images.githubusercontent.com/46852371/53679503-5bad4880-3cde-11e9-8d2b-c491c74b6ff4.jpg)
    
4) Green header, white text 
   ```sql
   select create_html_table(q'[select job_id, avg(salary) as "avg salary" 
                               from hr.employees 
                               group by job_id 
                               having avg(salary)>10000]', 30, '#27ae60', 'white') from dual
    ```
    ![4](https://user-images.githubusercontent.com/46852371/53679535-a3cc6b00-3cde-11e9-8283-92ab3bbd3cf0.jpg)

