import csv
import sys
import curses
stdscr = curses.initscr()
filename = 'suaci-2015_b.csv'
if len(sys.argv) > 1:
    filename = sys.argv[1]
c = 0
with open(filename, 'r') as csv_file:
    csv_rows = csv.reader(csv_file, delimiter=';')
    ncsv = '%s_timestamp.%s' % (filename.split('.')[0], filename.split('.')[1])
    with open(ncsv, 'w') as fixCSV:
        for row in csv_rows:
            time = row[5].split(' ')
            if row[5].find('fecha_ingreso') < 0:
                s = row[5].split(' ')
                year, month, day = time[0].split('-')
                date = time[1]
                date = date.split('.')[0]
                if len(date) > 5:
                    hour, mins, sec = date.split(':')
                else:
                    hour, mins = date.split(':')
                    sec = '00'
                time = '%s/%s/%sT%s:%s:%sZ' % (year,  month, day, hour, mins, sec)
                stdscr.addstr(0, 0, '>> %s ' % time)
                stdscr.refresh()
                c += 1
            else:
                time = 'timestamp'
            fixCSV.write('%s,%s,%s,%s,%s,%s,%s,%s\n' % (row[0], row[1], row[2], row[3], row[4], time, row[6], row[7]))
            fixCSV.flush()