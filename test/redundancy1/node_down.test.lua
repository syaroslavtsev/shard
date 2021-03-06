--# create server master1 with script='redundancy1/master1.lua', lua_libs='redundancy1/lua/shard.lua'
--# create server master2 with script='redundancy1/master2.lua', lua_libs='redundancy1/lua/shard.lua'
--# start server master1
--# start server master2
--# set connection default
shard.wait_connection()
shard.wait_table_fill()
shard.is_table_filled()

--# set connection master1
shard.wait_table_fill()
shard.is_table_filled()

--# set connection master2
shard.wait_table_fill()
shard.is_table_filled()

--# set connection default

-- Kill server and wait for monitoring fibers kill
--# stop server master1

-- Check that node is removed from shard
shard.wait_epoch(2)
shard.is_table_filled()

--# set connection master2
shard.wait_epoch(2)
shard.is_table_filled()

--# set connection default
--# stop server master2
--# cleanup server master1
--# cleanup server master2
--# stop server default
--# start server default
--# set connection default
