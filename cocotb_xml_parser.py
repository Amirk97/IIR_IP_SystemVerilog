import sys, os
from xml.etree.ElementTree import Element, tostring, SubElement, ElementTree, indent, parse

log_files = sys.argv[1:]
testsuites = Element('testsuites', name='results', tests='0', failures='0', errors='0')
failure_cnt = 0
error_cnt = 0
test_cnt = 0

for log_file in log_files:
    tree = parse(log_file)
    root = tree.getroot()
    test_cnt +=1

    for testsuite in root.findall("testsuite"):
        testsuites.append(testsuite)

    for failure in root.findall(".//failure"):
        failure_cnt += 1
        print("fond failure!!")

    for error in root.findall(".//error"):
        error_cnt += 1

testsuites.set('tests', str(test_cnt))
testsuites.set('failures', str(failure_cnt))
testsuites.set('errors', str(error_cnt))

indent(testsuites)
xml_str = tostring(testsuites, encoding='utf-8', method='xml')
print(xml_str.decode('utf-8'))

xml_path = os.path.join('test-results', 'results_cocotb.xml')

tree = ElementTree(testsuites)
tree.write(xml_path, encoding="utf-8", xml_declaration =True)
