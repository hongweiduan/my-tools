#!/usr/bin/python
import sys
import csv
import os

function_change_dict = {
    'mcu_send_cmd': {'to': 'commond', 'start_str': 'SCP:', 'end_str': '\n', 'need_param1': True, 'need_param2': False,
                     'connect_str': ''},
    'w2_send_cmd': {'to': 'commond', 'start_str': 'W2:', 'end_str': '\n', 'need_param1': True, 'need_param2': False,
                    'connect_str': ''},
    'apply': {'to': 'power', 'start_str': 'Set ', 'end_str': '', 'need_param1': True, 'need_param2': True,
              'connect_str': 'V in '}
}

class CSVWriter():
    def __init__(self,path):
        self.csv_fieldnames =[
        'Group name',
        'Items name',
        'LSL',
        'TYP',
        'USL',
        'Unit',
        'Command',
        'Power'
        ]
        outputfile = open(path,'a+')
        self.writer = csv.DictWriter(outputfile,fieldnames=self.csv_fieldnames)
        self.writer.writeheader()

    def writerow(self,row):
        self.writer.writerow(row)


def outputCsv(path):
    command_str,power_str,group_str = '','',''
    outputfile = os.path.dirname(os.path.abspath(path)) + '/' + 'output.csv'
    outcsv = CSVWriter(outputfile)
    with open(path, 'rb') as csvfile:
        reader = csv.DictReader(csvfile)

        for row in reader:
    	    if row['FUNCTION'] in function_change_dict:
    	        function_name = row['FUNCTION']
    	        function_list = function_change_dict[function_name]
                if function_list['to'] == 'power':
                    if row['PARAM1'] != 'off' and float(row['PARAM1']) > 1.5:
                        power_str = (function_list['start_str'] +
    	        		                    (function_list['need_param1'] and row['PARAM1'] or '') +
    	        		                    function_list['connect_str']+
    	        		                    (function_list['need_param2'] and row['PARAM2'] or '') +
    	        		                    function_list['end_str'])
                if function_list['to'] == 'commond':
					if row['PARAM1'] == 'ENTER':
						pass
					else:
						command_str += (function_list['start_str'] +
    	        		                    (function_list['need_param1'] and row['PARAM1'] or '') +
    	        		                    function_list['connect_str']+
    	        		                    (function_list['need_param2'] and row['PARAM2'] or '') +
    	        		                    function_list['end_str'])
            if 'ITEM_' in row['TID']:
                typ = ''
                group = ''
                if type(row['LOW']) != str and type(row['HIGH']) != str:
                    typ = (row['LOW']+row['HIGH'])/2.0
                if row['GROUP'] != group_str:
                    group = row['GROUP']
                outcsv.writerow({'Group name': group,
                                 'Items name':row['TID'][5:],
                                 'LSL':row['LOW'],
                                 'TYP':typ,
                                'USL':row['HIGH'],
                                'Unit':row['UNIT'],
                                'Command':command_str,
                                'Power':power_str
                                 })
                group_str = row['GROUP']
                command_str = ''
                power_str = ''

	# print(power_str)
    # print(command_str)
    # if 'ITEM_' in row['TID']


def main():
    PATH = sys.argv[1]
    outputCsv(PATH)

if __name__ == '__main__':
    main()
