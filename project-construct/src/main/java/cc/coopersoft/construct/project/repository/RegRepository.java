package cc.coopersoft.construct.project.repository;

import cc.coopersoft.common.data.RegStatus;
import cc.coopersoft.construct.project.model.ProjectReg;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface RegRepository extends CrudRepository<ProjectReg, Long>, JpaSpecificationExecutor<ProjectReg>, JpaRepository<ProjectReg,Long> {

    boolean existsByCodeAndStatus(long code, RegStatus status);

}
