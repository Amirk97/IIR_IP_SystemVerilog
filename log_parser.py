
import sys, os
from xml.etree.ElementTree import Element, tostring, SubElement, ElementTree, indent

log_files = sys.argv[1:]

testsuite = Element('testsuite', name='regression_suite', tests='0', failures='0', errors='0')
test_cnt = 0
error_cnt = 0
failure_cnt = 0
total_failure_cnt = 0
line_cnt = 0

for file in log_files:
    with open(file, "r", encoding="utf-8", errors="ignore") as f:
        lines = f.readlines()
        for line in lines:
            line_cnt +=1
            if "testname" in line.lower():
                parts = line.strip().split('=')
                testcase = SubElement(testsuite, 'testcase', classname='regression', name=parts[1])
                test_cnt+=1

            if "uvm_error :" in line.lower():
                parts = line.strip().split(':')
                failure_cnt += int(parts[1])


            if "uvm_fatal :" in line.lower():
                parts = line.strip().split(':')
                failure_cnt += int(parts[1])
                
        if failure_cnt > 0:
            failure = SubElement(testcase, 'failure', message='Check the logs', type='general')

        total_failure_cnt += failure_cnt
        failure_cnt = 0

testsuite.set('tests', str(test_cnt))
testsuite.set('failures', str(total_failure_cnt))

indent(testsuite)

xml_path = os.path.join('test-results', 'results.xml')


xml_str = tostring(testsuite, encoding='utf-8', method='xml')
print(xml_str.decode('utf-8'))

tree = ElementTree(testsuite)
tree.write(xml_path, encoding="utf-8", xml_declaration =True)
