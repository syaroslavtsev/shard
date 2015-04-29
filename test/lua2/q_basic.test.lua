--# create server master1 with script='lua2/master1.lua', lua_libs='lua2/lua/shard.lua'
--# create server master2 with script='lua2/master2.lua', lua_libs='lua2/lua/shard.lua'
--# start server master1
--# start server master2
--# set connection default
wait()

-- bipahse operations
shard.demo.q_insert(1, {0, 'test'})
shard.demo.q_replace(2, {0, 'test2'})
shard.demo.q_update(3, 0, {{'=', 2, 'test3'}})
shard.demo.q_insert(4, {1, 'test4'})
shard.demo.q_insert(5, {2, 'test_to_delete'})
shard.demo.q_delete(6, 2)

-- check for operation q_insert is in shard
shard.demo.check_operation(1, 0)
-- check for not exists operations
shard.demo.check_operation('12345', 0)

--# set connection default
wait()
box.space.demo:select()
--# set connection master1
box.space.demo:select()
--# set connection master2
box.space.demo:select()
--# set connection default

--# stop server master1
--# stop server master2
--# cleanup server master1
--# cleanup server master2
--# stop server default
--# start server default
--# set connection default