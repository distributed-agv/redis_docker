local car_id = ARGV[1]
local seq = ARGV[2]
local releasing_1 = ARGV[3]
local releasing_2 = ARGV[4]
local releasing_3 = ARGV[5]
local releasing_4 = ARGV[6]
local next_step = ARGV[7]


if not redis.call('GET', 'status') then
    math.randomseed(tonumber(redis.call('TIME')[1]))
    redis.call('SETNX', 'nonce', tostring(math.random(-2^15, -1)))
    return redis.call('GET', 'nonce')
end

seq = tonumber(seq)

local last_seq = tonumber(redis.call('GET', 'seq:'..car_id))
if seq + 1 == last_seq then
    return redis.call('GET', 'step_code:'..car_id)
elseif seq ~= last_seq then
    return '0'
end
redis.call('INCR', 'seq:'..car_id)

if(releasing_1~="")then
    redis.call('HDEL', 'owner_map', releasing_1)
end
if(releasing_2~="")then
    redis.call('HDEL', 'owner_map', releasing_2)
end
if(releasing_3~="")then
        redis.call('HDEL', 'owner_map', releasing_3)
end
if(releasing_4~="")then
    redis.call('HDEL', 'owner_map', releasing_4)
end


redis.call('SET', 'step_code:'..car_id, next_step)
return next_step