--# create server master1 with script='redundancy3/master1.lua', lua_libs='redundancy3/lua/shard.lua'
--# create server master2 with script='redundancy3/master2.lua', lua_libs='redundancy3/lua/shard.lua'
--# start server master1
--# start server master2
--# set connection default
shard.wait_connection()

-- bipahse operations
batch_obj = shard.q_begin()
batch_obj.demo:q_insert(1, {0, 'test'})
batch_obj.demo:q_replace(2, {0, 'test2'})
batch_obj.demo:q_update(3, 0, {{'=', 2, 'test3'}})
batch_obj.demo:q_insert(4, {1, 'test4'})
batch_obj.demo:q_insert(5, {2, 'test_to_delete'})
batch_obj.demo:q_delete(6, 2)
batch_obj:q_end()

--# set connection default
shard.wait_operations()
box.space.demo:select()
--# set connection master1
shard.wait_operations()
box.space.demo:select()
--# set connection master2
shard.wait_operations()
box.space.demo:select()
--# set connection default

-- check for operation q_insert is in shard
shard.demo:check_operation(6, 0)
-- check for not exists operations
shard.demo:check_operation('12345', 0)

box.space.operations:select()

--# stop server master1
--# stop server master2
--# cleanup server master1
--# cleanup server master2
--# stop server default
--# start server default
--# set connection default
