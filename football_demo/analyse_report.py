import pandas as pd 
 
"""
    leauge_analyse function  is called from servers.py  file  , this function returns 4 json data as tuple , look below of the  function 
"""
def leauge_analyse(leauge_name):
    desired_leauge=leauge_name

    def leauge_choose(desired_leauge):
        global leauge_df
        if desired_leauge=="Premier League":
            leauge_df=pd.read_csv("datasets/cleaned_premier.csv")
        elif desired_leauge=="Bundesliga":
            leauge_df=pd.read_csv("datasets/cleaned_bundesliga.csv")
        elif desired_leauge=="Serie A":
            leauge_df=pd.read_csv("datasets/cleaned_seriea.csv")
        elif desired_leauge=="Ligue 1":
            leauge_df=pd.read_csv("datasets/cleaned_leauge1.csv")
        elif desired_leauge=="Eredevise":
            leauge_df=pd.read_csv("datasets/cleaned_eredevise.csv")
        elif desired_leauge=="Süper Lig":
            leauge_df=pd.read_csv("datasets/cleaned_super_lig.csv")
        return leauge_df
    
    """
        below , all the lines work in same logic , i explained how i used value_counts below(inside of update_team_list function) you can read it 
    """

    # this will return leauge_df
    leauge_choose(desired_leauge)
    
    
    match_played_season=pd.DataFrame(leauge_df["season"].value_counts()[:3]).reset_index() # played match number for seasons
    match_played_season_json=match_played_season.to_json()
    
    winner=pd.DataFrame(leauge_df["winner"].value_counts()).reset_index()  # winner side 
    winner_json=winner.to_json()

    match_score=pd.DataFrame(leauge_df["match_score"].value_counts()[:15].sort_values(ascending=True)).reset_index() # match scores
    match_score_json=match_score.to_json()

    total_goal=pd.DataFrame(leauge_df["total_goal"].value_counts()).reset_index()# total goal numbers
    total_goal_json=total_goal.to_json()
    
    #,winner_json,match_score_json,total_goal_json 
    return match_played_season_json , winner_json , match_score_json , total_goal_json


  
"""
    leauge_analyse function calls this function(leauge_choose func) and leauge_choose func returns dataframe  
    return leauge dataframe , parameters : leauge_name
"""
def leauge_choose(desired_leauge):
    global leauge_df

    if desired_leauge=="Premier League":
        leauge_df=pd.read_csv("datasets/cleaned_premier.csv")
    elif desired_leauge=="Bundesliga":
        leauge_df=pd.read_csv("datasets/cleaned_bundesliga.csv")
    elif desired_leauge=="Serie A":
        leauge_df=pd.read_csv("datasets/cleaned_seriea.csv")
    elif desired_leauge=="Ligue 1":
        leauge_df=pd.read_csv("datasets/cleaned_leauge1.csv")
    elif desired_leauge=="Eredevise":
        leauge_df=pd.read_csv("datasets/cleaned_eredevise.csv")
    elif desired_leauge=="Süper Lig":
        leauge_df=pd.read_csv("datasets/cleaned_super_lig.csv")
    return leauge_df



"""
    update_team_list function is called from  leauge_list function which is in servers.py file .
     leauge_list function gives league name (it takes league name from flutter app)  and call it 
     here , update_team_list returns name of the teams in python list format 
"""
def update_team_list(leauge_name):  # return list of teams in specific leauge , parameters : leauge name

    desired_leauge=leauge_name

    # reading csv data and create data frame 
    if desired_leauge=="Premier League":
        leauge_df=pd.read_csv("datasets/cleaned_premier.csv")
    elif desired_leauge=="Bundesliga":
        leauge_df=pd.read_csv("datasets/cleaned_bundesliga.csv")
    elif desired_leauge=="Serie A":
        leauge_df=pd.read_csv("datasets/cleaned_seriea.csv")
    elif desired_leauge=="Ligue 1":
        leauge_df=pd.read_csv("datasets/cleaned_leauge1.csv")
    elif desired_leauge=="Eredevise":
        leauge_df=pd.read_csv("datasets/cleaned_eredevise.csv")
    elif desired_leauge=="Süper Lig":
        leauge_df=pd.read_csv("datasets/cleaned_super_lig.csv")
    
    """
        after creating dataframe , find team names in that specific league , for doing that i find all different team names in team_name1 column(you can csv file from datasets folder)
        with value_counts function and i take indexes , which are team names in that league
        
        example :
            leauge_df["team_name1"].value_counts() gives output like below 
            team_name1  
            Tottenham    31
            Chelsea      43
            Arsenal      93
        
        with .index i take only team_name1 column values which are indexes in this case and after that i convert them to python list with tolist() function
        and update_team_list returns that list : ["Chelsea","Arsenal","Brighton"......]
    """ 

    team_list=(leauge_df["team_name1"].value_counts().index.tolist()) 

    return team_list




"""
    team_analyse function  is called from servers.py  file  , this function returns 4 json data as tuple
"""

def team_analyse(leauge,team,side):
    
    #  team string  
    desired_team=team 
    desired_side=side
    print("desired sidesideside")
    print(desired_side)
    if leauge=="Premier League":
        league_df=pd.read_csv("datasets/cleaned_premier.csv")
    elif leauge=="Bundesliga":
        league_df=pd.read_csv("datasets/cleaned_bundesliga.csv")
    elif leauge=="Serie A":
        league_df=pd.read_csv("datasets/cleaned_seriea.csv")
    elif leauge=="Ligue 1":
        league_df=pd.read_csv("datasets/cleaned_leauge1.csv")
    elif leauge=="Eredevise":
        league_df=pd.read_csv("datasets/cleaned_eredevise.csv")
    elif leauge=="Süper Lig":
        league_df=pd.read_csv("datasets/cleaned_super_lig.csv")
    
    # choose dataframes rows with respect to side , if side is Home it only takes team_name1 , if side is Away it only takes team_name2
    if desired_side=="Home":
        league_df=league_df[league_df["team_name1"]==desired_team]

        first_half_side="first_half_home"
        second_half_side="second_half_home"
        total_scored_side="total_scored_home"

    elif desired_side=="Away":
        league_df=league_df[league_df["team_name2"]==desired_team]
        first_half_side="first_half_away"
        second_half_side="second_half_away"
        total_scored_side="total_scored_away"
    
    """
        below , all the lines work in same logic , i explained how i used value_counts above(inside of update_team_list function) you can read it 
    """
    
    team_win=league_df["winner"].value_counts().reset_index()
    team_first_half=league_df[first_half_side].value_counts().reset_index()
    team_second_half=league_df[second_half_side].value_counts().reset_index()
    team_total=league_df[total_scored_side].value_counts().reset_index()

    team_win_json=team_win.to_json()
    team_first_half_json=team_first_half.to_json()
    team_second_half_json=team_second_half.to_json()
    team_total_json=team_total.to_json()

    #,team_first_half,team_second_half,team_total
    return team_win_json , team_first_half_json , team_second_half_json , team_total_json

 