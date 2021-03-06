package cc.coopersoft.construct.corp.repository;

import cc.coopersoft.construct.corp.model.CorpEmployee;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CorpEmployeeRepository extends CrudRepository<CorpEmployee,Long> {

    List<CorpEmployee> findByCorpCodeOrderById(long code);

    @EntityGraph(value = "employee.full",type = EntityGraph.EntityGraphType.FETCH)
    List<CorpEmployee> findByValidIsTrueAndCorpEnableIsTrueAndUsername(String username);

}
