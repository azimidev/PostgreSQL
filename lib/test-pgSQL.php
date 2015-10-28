<?php
/*******************************************************************************
    test-pgSQL.php by Parsclick.net
*******************************************************************************/

define('TITLE', 'PHP testing sandbox');
define('VERSION', '1.1.2');
define('HEADER', '../assets/header.php');
define('BODY', '../assets/body.php');
define('FOOTER', '../assets/footer.php');

require_once 'pgSQL.php';

define("PGSQLUSER", "hassan");
define("PGSQLPASS", "azimi");
define("DATABASE", 'test');
define("TABLE", 't42');

_init();
main();
page();

function main()
{
    global $G;
    $G['query_start_time'] = microtime(TRUE);
    $tn = TABLE;

    message('this is %s v %s, database is %s, table is %s', $G['ME'], VERSION, DATABASE, TABLE);
    try {
        $db = new pgSQL(PGSQLUSER, PGSQLPASS, DATABASE, TABLE);
        message("initialized pgSQL version %s, connected to PostgreSQL server version %s", $db->version(), $db->version('pgsql'));
        $db->sql_do("DROP TABLE IF EXISTS $tn");
        $db->begin_transaction();
        $db->sql_do("CREATE TABLE $tn ( id SERIAL PRIMARY KEY, string TEXT, number INT )");
        $db->sql_do("INSERT INTO $tn (string, number) VALUES (?, ?)", 'one', 1);
        $db->sql_do("INSERT INTO $tn (string, number) VALUES (?, ?)", 'two', 2);
        $db->sql_do("INSERT INTO $tn (string, number) VALUES (?, ?)", 'three', 3);
        $db->commit();
    } catch (PDOException $e) {
        error($e->getMessage());
    }

    try {
        $bad_table = '91D776227E924E862EE5801F16821F7D';
        $db->timer_start();
        message('table_exists %s: %s (%s ms elapsed)', TABLE, $db->table_exists(TABLE) ? 'YES' : 'NO', $db->timer());
        $db->timer_start();
        message('table_exists %s: %s (%s ms elapsed)', $bad_table,
            $db->table_exists($bad_table) ? 'YES' : 'NO', $db->timer());
    } catch (PDOException $e) {
        error($e->getMessage());
    }

    message('all rows:');
    $db->timer_start();
    try {
        foreach ($db->sql_query("SELECT * FROM $tn") as $row) {
            message('id: %d, string: %s, number: %d', $row['id'], $row['string'], $row['number']);
        }
        message('&nbsp;-- %s ms elapsed', $db->timer());
    } catch (PDOException $e) {
        error($e->getMessage());
    }

    try {
        $row = $db->sql_query_row("SELECT * FROM $tn WHERE number = ?", 2);
        message("query_row (SELECT * FROM %s WHERE number = 2): string: %s number: %s", TABLE, $row['string'], $row['number']);
        $value = $db->sql_query_value("SELECT id FROM $tn WHERE number = ?", 3);
        message("query_value (SELECT id FROM %s WHERE number = 3): id: %s", TABLE, $value);
    } catch (PDOException $e) {
        error($e->getMessage());
    }

    try {
        $row = $db->get_rec(2);
        message('get_rec 2 -- id: %d, string: %s, number: %d', $row['id'], $row['string'], $row['number']);
    } catch (PDOException $e) {
        error($e->getMessage());
    }

    $db->timer_start();
    message('get_recs() ...');
    try {
        foreach( $db->get_recs() as $row ) {
            message('id: %d, string: %s, number: %d', $row['id'], $row['string'], $row['number']);
        }
        message('&nbsp;-- %s ms elapsed', $db->timer());
    } catch (PDOException $e) {
        error($e->getMessage());
    }
    message('count_recs: ' . $db->count_recs());

    try {
        $new_id = $db->insert(array( 'number' => 4, 'string' => 'four'));
        message("inserted new id (%d) ", $new_id);
    } catch (PDOException $e) {
        error($e->getMessage());
    }
    message('after insert count_recs: ' . $db->count_recs());

    try {
        foreach($db->get_recs() as $row) {
                message('id: %d, string: %s, number: %d', $row['id'], $row['string'], $row['number']);
        }
    } catch (PDOException $e) {
        error($e->getMessage());
    }

    message('update rec 2: ');
    try {
        $db->update(2, array( 'number' => 7, 'string' => 'seven'));
    } catch (PDOException $e) {
        error($e->getMessage());
    }
    $row = $db->get_rec(2);
    message('get_rec 2 -- id: %d, string: %s, number: %d', $row['id'], $row['string'], $row['number']);

    message('delete rec 2: ');
    try {
        $row = $db->delete(2);
    } catch (PDOException $e) {
        error($e->getMessage());
    }
    message('after delete count_recs: ' . $db->count_recs());
    foreach($db->get_recs() as $row) {
            message('id: %d, string: %s, number: %d', $row['id'], $row['string'], $row['number']);
    }

    message('DROP TABLE %s', $tn);
    $db->sql_do("DROP TABLE IF EXISTS $tn");
    $elapsed_time = microtime(TRUE) - $G['query_start_time'];
    message('whole set elapsed time: %s ms', number_format($elapsed_time * 1000, 2));
}

function _init( )
{
    global $G;
    $G['TITLE'] = TITLE;
    $G['ME'] = basename($_SERVER['SCRIPT_FILENAME']);

    // initialize display vars
    foreach ( array( 'MESSAGES', 'ERRORS', 'CONTENT' ) as $v )
        $G[$v] = "";
}

function page( )
{
    global $G;
    set_vars();

    require_once(HEADER);
    require_once(BODY);
    require_once(FOOTER);
    exit();
}

// Utility functions

function set_vars( )
{
    global $G;
    if(isset($G["_MSG_ARRAY"])) foreach ( $G["_MSG_ARRAY"] as $m ) $G["MESSAGES"] .= $m;
    if(isset($G["_ERR_ARRAY"])) foreach ( $G["_ERR_ARRAY"] as $m ) $G["ERRORS"] .= $m;
    if(isset($G["_CON_ARRAY"])) foreach ( $G["_CON_ARRAY"] as $m ) $G["CONTENT"] .= $m;
}

function content( $s )
{
    global $G;
    $G["_CON_ARRAY"][] = "\n<div class=\"content\">$s</div>\n";
}

function message()
{
    global $G;
    $args = func_get_args();
    if(count($args) < 1) return;
    $s = vsprintf(array_shift($args), $args);
    $G["_MSG_ARRAY"][] = "<p class=\"message\">$s</p>\n";
}

function error_message()
{
    global $G;
    $args = func_get_args();
    if(count($args) < 1) return;
    $s = vsprintf(array_shift($args), $args);
    $G["_ERR_ARRAY"][] = "<p class=\"error_message\">$s</p>\n";
}

function error( $s )
{
    error_message($s);
    page();
}

?>
