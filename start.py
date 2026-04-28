import os, json

FilesList = os.listdir("DB")
if "data.in" in FilesList:
    os.remove("DB/data.in")
    FilesList = os.listdir("DB")

result = {}

def open_file(name):
    file = open(f"DB/{name}")
    data = file.read()
    file.close()
    return data

def sort_info(data):
    scores = [v for v in data.values()]
    scores = sorted(scores, reverse=True)

    for i in range( len(scores) ):
        result.update( {next(ch for ch, code in data.items() if code == scores[i] ): scores[i]} )

def start():
    all_player_info = {}
    player_money = {}

    for i in range( len(FilesList) ):
        data = open_file( FilesList[i] )
        info = eval( str(data) )
        all_player_info.update( {info["name"]: info["score"] } )
        player_money.update( {info["name"]: info['money']} )

    sort_info(all_player_info)

    for i in result.keys():
        data = result[i]
        money = player_money[i]
        result[i] = [data, money]
        
    return result

data_dumps = json.dumps(start(), indent=4, ensure_ascii=False)
file = open("DB/data.in", "w")
file.write(data_dumps)
file.close()
