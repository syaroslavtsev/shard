--# create server master1 with script='node_down/master1.lua', lua_libs='node_down/lua/shard.lua'
--# start server master1
--# set connection default
shard.wait_connection()

-- bipahse operations
shard.demo:q_insert(1, {0, 'test'})
shard.demo:q_replace(2, {0, 'test2'})
shard.demo:q_update(3, 0, {{'=', 2, 'test3'}})

--# stop server master1

shard.demo:q_insert(4, {1, 'test4'})
shard.demo:q_insert(5, {2, 'test_to_delete'})
shard.demo:q_delete(6, 2)

shard.wait_operations()
box.space.demo:select()

-- check for operation q_insert is in shard
shard.demo:check_operation(1, 0)
-- check for not exists operations
shard.demo:check_operation('12345', 0)

--# cleanup server master1
--# stop server default
--# start server default
--# set connection default
