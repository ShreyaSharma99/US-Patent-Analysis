from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
db = SQLAlchemy(app)

# comment in submission
#postgres = {
#    'user' : 'postgres',
#    'pw' : 'hello_world',
#    'db' : 'my_database',
#    'host' : 'localhost',
#    'port' : '5432'
#}
# valid for submission
postgres = {
    'user' : 'group_6',
    'pw' : 'hw8bYsVcA1MdU',
    'db' : 'group_6',
    'host' : '10.17.5.99',
    'port' : '5432'
}

# connecting with postreSQL
app.config['DEBUG'] = True
app.config['SQLALCHEMY_DATABASE_URI'] = \
    'postgresql://%(user)s:%(pw)s@%(host)s:%(port)s/%(db)s' % postgres
db.init_app(app)

def sql(raw_sql, sql_vars = {}):
    """ 
        Used to execute pure sql queries.
        Anything returned by sql() function is an
        iterator. It can be traversed only once.
    """
    result = db.session.execute(raw_sql, sql_vars)
    db.session.commit()
    return result

@app.before_first_request
def initializeDatabase():
    """
        Create all tables, views, definitions, etc. if they don't already exists
    """
    print('***** Initializing the database tables if not already exist...')
    with open('db.sql', 'r') as file:
        db_build_script = file.read().replace('\n', ' ')
    log = sql(db_build_script)

@app.route("/")
def introduce():
    return render_template('index.html')

@app.route("/templates/query1.html")
def query1():
    return render_template('query1.html')
@app.route("/templates/query2.html")
def query2():
    return render_template('query2.html')
@app.route("/templates/query3.html")
def query3():
    return render_template('query3.html')
@app.route("/templates/query4.html")
def query4():
    return render_template('query4.html')
@app.route("/templates/query5.html")
def query5():
    return render_template('query5.html')
@app.route("/templates/query6.html")
def query6():
    return render_template('query6.html')
@app.route("/templates/query7.html")
def query7():
    return render_template('query7.html')
@app.route("/templates/s_stats<id>.html")
def s_stats3(id):
    return render_template('s_stats{}.html'.format(id))
@app.route("/templates/r_stats<id>.html")
def r_stats(id):
    return render_template('r_stats{}.html'.format(id))
# delete Queries
@app.route("/templates/delete<id>.html")
def delete_(id):
    return render_template('delete{}.html'.format(id))
# update Queries
@app.route("/templates/update<id>.html")
def update_(id):
    return render_template('update{}.html'.format(id))
# insert Queries
@app.route("/templates/insert<id>.html")
def insert_(id):
    return render_template('insert{}.html'.format(id))

# handling the form request
@app.route('/form-handler1', methods=['POST'])
def handle_data1():
    with open('./templates/r_io_query1.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
    doc_grant_number = request.form['doc_grant_number']
    table_content = sql(query.format(doc_grant_number))
    return render_template('query1.html', users = table_content)
# handling the form request
@app.route('/form-handler2', methods=['POST'])
def handle_data2():
    with open('./templates/r_io_query2.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
    search_string = request.form['search_string']
    table_content = sql(query.format(search_string))
    return render_template('query2.html', users = table_content)
# handling the form request
@app.route('/form-handler3', methods=['POST'])
def handle_data3():
    with open('./templates/r_io_query3.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
    assignor_name = request.form['assignor_name']
    table_content = sql(query.format(assignor_name))
    return render_template('query3.html', users = table_content)
# handling the form request
@app.route('/form-handler4', methods=['POST'])
def handle_data4():
    with open('./templates/s_io_query1.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
    first_char = request.form['first_char']
    country = request.form['country'].upper()
    first_char_small = first_char.lower()
    first_char_big = first_char.upper()
    table_content = sql(query.format(first_char_small, first_char_big, country, first_char_small, first_char_big, country))
    return render_template('query4.html', users = table_content)
# handling the form request
@app.route('/form-handler5', methods=['POST'])
def handle_data5():
    with open('./templates/s_io_query2.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
    assignor_name = request.form['assignor_name']
    table_content = sql(query.format(assignor_name, assignor_name))
    return render_template('query5.html', users = table_content)
# handling the form request
@app.route('/form-handler6', methods=['POST'])
def handle_data6():
    with open('./templates/s_io_query3.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
    assignor_name = request.form['assignor_name']
    table_content = sql(query.format(assignor_name, assignor_name, assignor_name))
    return render_template('query6.html', users = table_content)
# handling the form request
@app.route('/form-handler7', methods=['POST'])
def handle_data7():
    with open('./templates/s_io_query4.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
    assignor_name = request.form['assignor_name']
    assignee_name = request.form['assignee_name']
    table_content = sql(query.format(assignor_name, assignee_name))
    return render_template('query7.html', users = table_content)
# handling stat requests
@app.route('/s_stats<id>-form-handler', methods=['POST'])
def s_stats_formhandler(id):
    with open('templates/s_stats{}.sql'.format(id), 'r') as file:
        query = file.read().replace('\n', ' ')
        result = sql(query)
    return render_template('s_stats{}.html'.format(id), result = result )
@app.route('/r_stats<id>-form-handler', methods=['POST'])
def r_stats_formhandler(id):
    with open('templates/r_stats{}.sql'.format(id), 'r') as file:
        query = file.read().replace('\n', ' ')
        result = sql(query)
    return render_template('r_stats{}.html'.format(id), result = result )
# delete queries
@app.route('/form-handler<id>_delete', methods=['POST'])
def delete_formhandler(id):
    with open('templates/delete{}.sql'.format(id), 'r') as file:
        query = file.read().replace('\n', ' ')
        doc_grant_number = request.form['doc_grant_number']
        result = sql(query.format(doc_grant_number))
    return render_template('delete{}.html'.format(id), users = result)
# update queries
@app.route('/form-handler1_update', methods=['POST'])
def update1_formhandler():
    with open('templates/update1.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
        new_rf_id = request.form['new_rf_id']
        old_rf_id = request.form['old_rf_id']
        result = sql(query.format(new_rf_id, old_rf_id))
    return render_template('update1.html', users = result )
# update queries
@app.route('/form-handler2_update', methods=['POST'])
def update2_formhandler():
    with open('templates/update2.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
        caddress1 = request.form['caddress1']
        caddress2 = request.form['caddress2']
        caddress3 = request.form['caddress3']
        caddress4 = request.form['caddress4']
        rf_id = request.form['rf_id']
        cname = request.form['cname']
        result = sql(query.format(caddress1, caddress2, caddress3, caddress4, rf_id, cname))
    return render_template('update2.html', users = result )
# update queries
@app.route('/form-handler3_update', methods=['POST'])
def update3_formhandler():
    with open('templates/update3.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
        ee_address1 = request.form['ee_address1']
        ee_address2 = request.form['ee_address2']
        ee_city = request.form['ee_city']
        ee_state = request.form['ee_state']
        ee_postcode = request.form['ee_postcode']
        ee_country = request.form['ee_country']
        rf_id = request.form['rf_id']
        ee_name = request.form['ee_name']
        result = sql(query.format(ee_address1, ee_address2, ee_city, ee_state, ee_postcode, ee_country, rf_id, ee_name))
    return render_template('update3.html', users = result )
# update queries
@app.route('/form-handler4_update', methods=['POST'])
def update4_formhandler():
    with open('templates/update4.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
        ack_date = request.form['ack_date']
        rf_id = request.form['rf_id']
        assignor_name = request.form['assignor_name']
        result = sql(query.format(ack_date, rf_id, assignor_name, ack_date))
    return render_template('update4.html', users = result )
# insert queries
@app.route('/form-handler1_insert', methods=['POST'])
def insert1_formhandler():
    with open('templates/insert1.sql', 'r') as file:
        query = file.read().replace('\n', ' ')
        # query 1
        cname = request.form['cname']
        caddress1 = request.form['caddress1']
        caddress2 = request.form['caddress2']
        caddress3 = request.form['caddress3']
        caddress4 = request.form['caddress4']
        convey_text = request.form['convey_text']
        page_count = request.form['page_count']
        # query 2
        assignor_name = request.form['assignor_name']
        exec_date = request.form['exec_date']
        # query 3
        ee_name = request.form['ee_name']
        ee_city = request.form['ee_city']
        ee_state = request.form['ee_state']
        ee_postcode = request.form['ee_postcode']
        ee_country = request.form['ee_country']
        # query 4
        title = request.form['title']
        appno_doc_num = request.form['appno_doc_num']
        appno_date = request.form['appno_date']
        appno_country = request.form['appno_country']
        doc_grant_number = request.form['doc_grant_number']
        grant_date = request.form['grant_date']
        # query 5
        app_doc_num = request.form['appno_doc_num']
        doc_grant_number = request.form['doc_grant_number']
        admin_appl_id_for_grant = request.form['admin_appl_id_for_grant']
        admin_pat_no_for_appno = request.form['admin_pat_no_for_appno']
        error = request.form['error']

        result = sql(query.format(\
            cname, caddress1, caddress2, caddress3, caddress4, convey_text, page_count,\
            assignor_name, exec_date,\
            ee_name, ee_city, ee_state, ee_postcode, ee_country,\
            title, appno_doc_num, appno_date, appno_country, doc_grant_number, grant_date,\
            app_doc_num, doc_grant_number, admin_appl_id_for_grant, admin_pat_no_for_appno, error\
            ))
    return render_template('insert1.html', users = result )

if __name__ == '__main__':
    app.run("127.0.0.1", 5006)
