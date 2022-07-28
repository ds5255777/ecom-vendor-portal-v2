package com.main.db;

/*@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
  entityManagerFactoryRef = "barEntityManagerFactory",
  transactionManagerRef = "barTransactionManager",
  basePackages = { "com.test.db.other.repo" }
)*/
public class OtherDbConnection {
  
  
	/* @Bean(name = "barDataSource")
	  @ConfigurationProperties(prefix = "bar.datasource")
	  public DataSource dataSource() {
	    return DataSourceBuilder.create().build();
	  }
	  
	  @Bean(name = "barEntityManagerFactory")
	  public LocalContainerEntityManagerFactoryBean 
	  barEntityManagerFactory(
	    EntityManagerFactoryBuilder builder,
	    @Qualifier("barDataSource") DataSource dataSource
	  ) {
	    return
	      builder
	        .dataSource(dataSource)
	        .packages("com.test.db.other.entity")
	        .persistenceUnit("bar")
	        .build();
	  }
	  @Bean(name = "barTransactionManager")
	  public PlatformTransactionManager barTransactionManager(
	    @Qualifier("barEntityManagerFactory") EntityManagerFactory
	    barEntityManagerFactory
	  ) {
	    return new JpaTransactionManager(barEntityManagerFactory);
	  }*/
}