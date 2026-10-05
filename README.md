# `dbk_json`
stb-style single-file public domain ANSI C JSON Parser


# References
## Standards
- https://ecma-international.org/wp-content/uploads/ECMA-404_2nd_edition_december_2017.pdf
- https://www.rfc-editor.org/info/rfc8259/
## Testing
- https://seriot.ch/security/parsing_json.html
- https://github.com/nst/JSONTestSuite

### Failing Tests
```text
test/i_string_UTF-16LE_with_BOM.json FAILED
test/i_string_utf16BE_no_BOM.json FAILED
test/i_string_utf16LE_no_BOM.json FAILED
test/i_structure_UTF-8_BOM_empty_object.json FAILED
test/n_multidigit_number_then_00.json FAILED
test/n_structure_100000_opening_arrays.json FAILED
test/n_structure_open_array_object.json FAILED
```
These concern JSONs prefix with BOMs or nesting depth both of which could be
fixed later.
