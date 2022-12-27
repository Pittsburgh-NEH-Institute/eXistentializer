xquery version "3.0";

(: https://github.com/joewiz/exist/wiki/xqsuite :)

module namespace m="http://foo.org/xquery/math";

declare namespace tests="http://http://www.obdurodon.org/app/init-test/tests";
import module namespace f="http://www.obdurodon.org/app/init-test/model" at "../modules/lib.xql";
declare namespace test="http://exist-db.org/xquery/xqsuite";

declare
    %test:arg("n", 1) %test:assertEquals(1)
    %test:arg("n", 5) %test:assertEquals(120)
    %test:arg("n", 1) %test:assertEquals(10000) (: should fail :)
function tests:factorial($n as xs:int) as xs:int {
    f:factorial($n)
};
