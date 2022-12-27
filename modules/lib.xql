xquery version "3.0";

(: Based on https://github.com/joewiz/exist/wiki/xqsuite :)
(: Uses project-specific namespaces :)

module namespace m="http://www.obdurodon.org/app/init-test/model";

declare function m:factorial($n as xs:int) as xs:int {
    if ($n = 1) then
        1
    else
        $n * m:factorial($n - 1)
};
