# lua-cwmp

## Purpose

Discovery, Experimental
I have 3 previous proprietary closed source CWMP implementations

## Scope

- Testing around on creating CWMP in Lua
- Library 
- Server
- Client
- RESTful API

## Vision

- Platform
* Use openresty (NGINX/LuaJIT)
- XML Library
* Use RapidXML via lubyk/xml (Forked)
* Consider FFI if staying with Lua & LuaJIT
* Parse SOAP but no SOAP libraries avail ofcourse
* A lot of XML libraries are broken
* Tests
* Ability to handle broken XML (hey world is not perfect!)
* Evrything is API including tokenized data access
* ..
