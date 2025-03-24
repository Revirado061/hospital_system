package org.example.springboothospitalsystem.utils;

import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.concurrent.TimeUnit;

@Component
public class RedisLockUtils {
    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    public RedisLockUtils(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }


    // 尝试获取锁
    public boolean tryLock(String key, String value, long timeout, TimeUnit timeUnit) {
        // 使用 Redis 的 SETNX 命令尝试获取锁
        Boolean result = redisTemplate.opsForValue().setIfAbsent(key, value, timeout, timeUnit);
        return result != null && result;
    }

    // 释放锁
    public void unlock(String key, String value) {
        // 使用 Lua 脚本释放锁，确保只有锁的持有者才能释放锁
        String script = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
        redisScript.setScriptText(script);
        redisScript.setResultType(Long.class);
        redisTemplate.execute(redisScript, Collections.singletonList(key), value); // 执行脚本，传入键和参数
    }
}