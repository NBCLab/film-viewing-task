import json

bold_description_st = {
    'CogAtlasID': 'trm_4c898da401420',
    'TaskName': 'Stranger Things'
}

bold_description_hf = {
    'CogAtlasID': 'trm_4c898da401420',
    'TaskName': 'Hidden Figures'
}

with open('task-strangerthings_bold.json', 'w') as fo:
    json.dump(bold_description_st, fo, sort_keys=True, indent=4)

with open('task-hiddenfigures_bold.json', 'w') as fo:
    json.dump(bold_description_hf, fo, sort_keys=True, indent=4)
