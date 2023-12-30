from flask import Flask, jsonify,request
from analyse_report import leauge_analyse,update_team_list,team_analyse
import json
import time
 
app = Flask(__name__)


# LEAUGE PART

"""
    I used flask for communcating between dart and python , in most of this functions functions take input from app in format of json ,
    and functions returns some output in format of json again
"""  

# leauge_list function 
"""
    app first make request to leauge_list function with input(league name) and here leauge_list function take the input (league list name) and
    send it to the update_team_list function which is in analyse_report.py file and  update_team_list function returns name of teams in that list
    
    Example :   update_team_list("Premier League") --> this return list like ["Arsenal","Chelsea".......] all the teams in premier league 

    and it returns json file to the flutter app which contains list of teams in that particular league 

    first this function is called from app because 'leauge_name' variable is used in every function in this file , as you can see from above it is global variable therefore it can
    be used in every function in this file 
"""
@app.route('/leauge_list', methods=['POST','GET'])
def leauge_list():

    global leauge_name
    leauge_name = request.form['leauge_name']
    # print(leauge_name) # lig ismi başarılı bir şekilde buraya geliyor
    llist=update_team_list(leauge_name)
    time.sleep(0.1)

    return jsonify({"llist": llist}) # return list of teams in json format


# get_data,get_data2,get_data3,get_data4 functions
"""
    after leauge_list function ,  functions that are below can be used without problem because only leauge_name is needed for those funcs. and it is global variable.
    those functions work like each other , they can be used together actually and in future i will combine them as a one function 
    they call leauge_analyse function and they return json files to the flutter app , (json data comes from leauge_analyse function  )
    
    data as json format just like below : (leauge_analyse function gives this)
  0)  ('{"season":{"0":"2020\\/2021","1":"2022\\/2023","2":"2021\\/2022"},"count":{"0":399,"1":381,"2":380}}', 
  1)  '{"winner":{"0":"Home","1":"Away","2":"Draw"},"count":{"0":474,"1":388,"2":298}}', 
  2) '{"match_score":{"0":"2-3","1":"0-3","2":"3-2","3":"1-3","4":"3-0"............., "count":{"0":21,"1":27,"2":35,"3":38,"4":40, more.....}
  3)  '{"total_goal":{"0":2,"1":3,"2":4,"3":1,"4":5,"5":0,"6":6,"7":7,"8":8,"9":10},"count":{"0":298,"1":246,"2":186,"3":180,"4":93,"5":61,"6":49,"7":40,"8":6,"9":1}}')

    
    every function below takes one part of the data , you can see analyse_report file and understand how it works 
    
    example : data=leauge_analyse(leauge_name)[0] takes first part ,  it takes --> 0) --> '{"season":{"0":"2020\\/2021","1":"2022\\/2023","2":"2021\\/2022"},"count":{"0":399,"1":381,"2":380}}', 
                data=leauge_analyse(leauge_name)[1]  takes --> 1) --> '{"winner":{"0":"Home","1":"Away","2":"Draw"},"count":{"0":474,"1":388,"2":298}}', 

    those functions(season_match_count,side_winner_count,match_score_count,total_goal_count) returns flutter app this json datas and app use them to graphing bar plots

    {"season":{"0":"2020\\/2021","1":"2022\\/2023","2":"2021\\/2022"},"count":{"0":399,"1":381,"2":380}}', --> first parts are indexes in flutter bar and seconds are y values in bar plots

    """

@app.route('/season_match_count')
def get_data():
    
    data=leauge_analyse(leauge_name)[0]
    
    return data # directly sending data to flutter because data comes from leauge_analyse function in json form


@app.route('/side_winner_count')
def get_data2():
    
    data=leauge_analyse(leauge_name)[1]     
    return data

@app.route('/match_score_count')
def get_data3():
    
    data=leauge_analyse(leauge_name)[2]
     
    return data

@app.route('/total_goal_count')
def get_data4():
    
    data=leauge_analyse(leauge_name)[3]
     
    return data





# TEAM PART 
"""
    team_request function take data from app and make those datas global variables  , so other functions (team_report,team_report2,team_report3,team_report4) 
    can use those global variables . Those functions send those datas to the team_analyse function which is in analyse_report.py file
    team_analyse returns data just like league_analyse function , you can read above for how data processing and transfering working 

    team_analyse function takes three argument and those arguments are created in team_request function : name_of_the_leauge,name_of_the_team,side_of_the_team

"""

@app.route('/team_request', methods=['POST','GET'])
def team_request():

     # actually this function dont returns anything to the flutter app , it takes data and make those datas global variable and other functions
    # use those data , you can think of this data as a bridge b

    global name_of_the_leauge,name_of_the_team,side_of_the_team
    name_of_the_leauge=request.form['leauge_name']
    name_of_the_team=request.form['team_name']
    side_of_the_team=request.form["team_side"]
    
    time.sleep(0.1)

    return "yeter artik allahim" # some string otherwise it gives error 


@app.route('/team_report', methods=['POST','GET'])
def team_report():
    
    return team_analyse(name_of_the_leauge,name_of_the_team,side_of_the_team)[0]

@app.route('/team_report2', methods=['POST','GET'])
def team_report2():
    
    return team_analyse(name_of_the_leauge,name_of_the_team,side_of_the_team)[1]

@app.route('/team_report3',methods=['POST','GET'])
def team_report3():
    return team_analyse(name_of_the_leauge,name_of_the_team,side_of_the_team)[2]

@app.route('/team_report4', methods=['POST','GET'])
def team_report4():
    
    return team_analyse(name_of_the_leauge,name_of_the_team,side_of_the_team)[3]






if __name__ == '__main__':
     app.run(debug=True, host='0.0.0.0', port=50162)

 
 