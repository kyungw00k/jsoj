/**
 * _testScript_
 * 
 * @param _funcstr_
 * @param _str_
 * @returns JSON String
 */
function _testScript_(_funcstr_,_str_) {
    var array = _str_.split("\n");
    for ( item in array ) {
        array[item] = '['+array[item]+']';
    }
    var _json_ = '{tcases:['+array.join(',')+']}';
    var _ret_  = [];
    var _obj_  = null;
    var _func_ = null;
    try {
        _obj_  = eval('('+_json_+')');
        _func_ = eval(_funcstr_);
    } catch ( e ) {
        return e.toString();
    }
    if (!_obj_.tcases) {
        // throw exception
    }
    var tcases = _obj_.tcases;
    for ( var idx = 0, len = tcases.length ; idx < len ; ++idx ) {
        _ret_.push(_func_.apply(this, tcases[idx]));
    }
    return _ret_.join('\n');
}