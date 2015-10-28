import csv
import sys

filename = 'suaci-2015_b.csv'
if len(sys.argv) > 1:
    filename = sys.argv[1]
c = 0
with open(filename, 'r') as csv_file:
    csv_rows = csv.reader(csv_file, delimiter=';')
    ncsv = '%s_fixed.%s' % (filename.split('.')[0], filename.split('.')[1])
    with open(ncsv, 'w') as fixCSV:
        for row in csv_rows:
            print row[5],', ', row[5].find('fecha_ingreso')
            time = row[5].split(' ')
            if row[5].find('fecha_ingreso') < 0:
                s = row[5].split(' ')
                print s,', ', str(c)
                year, month, day = time[0].split('-')
                date = time[1]
                date = date.split('.')[0]
                if len(date) > 5:
                    hour, mins, sec = date.split(':')
                else:
                    hour, mins = date.split(':')
                    sec = '00'
                time = '%s/%s/%sT%s:%s:%s-03:00' % (year, month, day, hour, mins, sec)
                print '>> %s ' % time
                c += 1
            else:
                time = time[0]
            fixCSV.write('%s,%s,%s,%s,%s,%s,%s,%s\n' % (row[0], row[1], row[2], time, row[4], row[5], row[6], row[7]))
            fixCSV.flush()