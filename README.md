smxremarks
==========

Extension for OXID eShop to manage customer and order notices, emails and history.

Originally registered: 2011-12-23 by @tabsl on former OXIDprojects.

Title
-----
smxRemarks
   
Author
------
shoptimax GmbH
   
Prefix
------
smx
  
Version
-------
1.0
 
Link
----
www.shoptimax.de
  
Mail
----
support@shoptimax.de
 
Description
-----------
Module for OXID eShop to manage customer and order notices, emails and history.
 
Installation
------------
1. read documentation
2. upload content of "copy_this" into the shop-root-directory
3. execute install.sql (Shop-Admin -> Service --> Tools)
4. update views  (Shop-Admin -> Service --> Tools) [all EE 4.x and all 4.5.x only]
5. add module entries in admin (Shop-Admin --> Master Settings --> Core Settings --> System --> Modules)
6. delete content of compile-directory (default: /tmp)

Modules
-------
order_remark => smxRemarks/admin/smx_order_remark<br>
user_remark => smxRemarks/admin/smx_user_remark

Extend
------
*order_remark<br>
--render<br>
--save<br>
*user_remark<br>
--render<br>
--save