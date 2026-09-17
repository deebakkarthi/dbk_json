/* These guards prevent the header file from appearing in multiple places
 * We only go into this section if `INCLUDE_DBK_JSON_H has never been defined
 * and we define it as soon as we're inside. If a second src file includes
 * json.h, the preprocessor will just skip these as `DBK_INCLUDE_JSON_H` would
 * have been defined by the first file*/
#ifndef INCLUDE_DBK_JSON_H
#define INCLUDE_DBK_JSON_H
#endif /*INCLUDE_DBK_JSON_H*/

/*
 * This enables the implementation
 * Atleast one src file has to define `DBK_JSON_IMPLEMENTATION`
 * We don't want this to be guarded by the header guards as that may
 * prevent the implementation from ever being included.
 * For example if multiple file include `json.h` and one file defines
 * `DBK_JSON_IMPLEMENTATION` but if it is not processed first then the
 * preprocessor will never include the implementation.
 * */
#ifdef DBK_JSON_IMPLEMENTATION
#endif /*DBK_JSON_IMPLEMENTATION*/
