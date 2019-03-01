# HTML table from SQL query string
  ------------------------------------------------------
  ----------------------------------------------------------------------------
  --in params:
  --1) sql_in -- sql query string
  --2) table_width_prc -- width of html table in %
  --3) head_bg_col -- background colour in header, default '#FFFFFF' (white)
  --4) text_head_col -- colour of text in header, default 'black'
  --out: html string 
  ----------------------------------------------------------------------------
  -----------------------------------------------------


Examples using hr schema: 

1) select create_html_table(q'[select * from hr.employees where rownum < 10]',30) from dual

<!DOCTYPE html>
                        <html>
                        <head>
                        <style>
                        table {
                          border-collapse: collapse;
                          width: 30%;
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
                          background-color: #FFFFFF;
                          color: black;
                          border: 1px solid #ddd;
                        }
                        </style>
                        </head><body> <table><th>EMPLOYEE_ID</th><th>FIRST_NAME</th><th>LAST_NAME</th><th>EMAIL</th><th>PHONE_NUMBER</th><th>HIRE_DATE</th><th>JOB_ID</th><th>SALARY</th><th>COMMISSION_PCT</th><th>MANAGER_ID</th><th>DEPARTMENT_ID</th><tr><td>100</td><td>Steven</td><td>King</td><td>SKING</td><td>515.123.4567</td><td>17-JUN-03</td><td>AD_PRES</td><td>24000</td><td></td><td></td><td>90</td></tr><tr><td>101</td><td>Neena</td><td>Kochhar</td><td>NKOCHHAR</td><td>515.123.4568</td><td>21-SEP-05</td><td>AD_VP</td><td>17000</td><td></td><td>100</td><td>90</td></tr><tr><td>102</td><td>Lex</td><td>De Haan</td><td>LDEHAAN</td><td>515.123.4569</td><td>13-JAN-01</td><td>AD_VP</td><td>17000</td><td></td><td>100</td><td>90</td></tr><tr><td>103</td><td>Alexander</td><td>Hunold</td><td>AHUNOLD</td><td>590.423.4567</td><td>03-JAN-06</td><td>IT_PROG</td><td>9000</td><td></td><td>102</td><td>60</td></tr><tr><td>104</td><td>Bruce</td><td>Ernst</td><td>BERNST</td><td>590.423.4568</td><td>21-MAY-07</td><td>IT_PROG</td><td>6000</td><td></td><td>103</td><td>60</td></tr><tr><td>105</td><td>David</td><td>Austin</td><td>DAUSTIN</td><td>590.423.4569</td><td>25-JUN-05</td><td>IT_PROG</td><td>4800</td><td></td><td>103</td><td>60</td></tr><tr><td>106</td><td>Valli</td><td>Pataballa</td><td>VPATABAL</td><td>590.423.4560</td><td>05-FEB-06</td><td>IT_PROG</td><td>4800</td><td></td><td>103</td><td>60</td></tr><tr><td>107</td><td>Diana</td><td>Lorentz</td><td>DLORENTZ</td><td>590.423.5567</td><td>07-FEB-07</td><td>IT_PROG</td><td>4200</td><td></td><td>103</td><td>60</td></tr><tr><td>108</td><td>Nancy</td><td>Greenberg</td><td>NGREENBE</td><td>515.124.4569</td><td>17-AUG-02</td><td>FI_MGR</td><td>12008</td><td></td><td>101</td><td>100</td></tr></table> </body> </html>

