//package com.github.flying.jeelite.modules.config;
//
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.ApplicationListener;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.event.ContextRefreshedEvent;
//
//import com.github.flying.jeelite.common.utils.CacheUtils;
//import com.github.flying.jeelite.modules.sys.dao.DictDao;
//import com.github.flying.jeelite.modules.sys.entity.Dict;
//import com.github.flying.jeelite.modules.sys.utils.DictUtils;
//import com.google.common.collect.Lists;
//import com.google.common.collect.Maps;
//
///**
// * 系统的初始化
// *
// */
//@Configuration
//public class SystemInit implements ApplicationListener<ContextRefreshedEvent> {
//
//	@Autowired
//	private DictDao dictDao;
//
//	@Override
//	public void onApplicationEvent(ContextRefreshedEvent event) {
//		Map<String, List<Dict>> dictMap = Maps.newHashMap();
//		for (Dict dict : dictDao.findAllList(new Dict())) {
//			List<Dict> dictList = dictMap.get(dict.getType());
//			if (dictList != null) {
//				dictList.add(dict);
//			} else {
//				dictMap.put(dict.getType(), Lists.newArrayList(dict));
//			}
//		}
//		CacheUtils.put(DictUtils.CACHE_DICT_MAP, dictMap);
//	}
//
//}