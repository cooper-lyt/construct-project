package cc.coopersoft.construct.project.controllers;


import cc.coopersoft.construct.project.model.BuildReg;
import cc.coopersoft.construct.project.model.JoinCorp;
import cc.coopersoft.construct.project.model.Project;
import cc.coopersoft.construct.project.model.ProjectRegInfo;
import cc.coopersoft.construct.project.services.BusinessService;
import cc.coopersoft.construct.project.services.ProjectServices;
import com.fasterxml.jackson.annotation.JsonView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value="view")
public class MasterController {

    private final BusinessService businessService;
    private final ProjectServices projectServices;

    @Autowired
    public MasterController(BusinessService businessService, ProjectServices projectServices) {
        this.businessService = businessService;
        this.projectServices = projectServices;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @JsonView(Project.Summary.class)
    public Page<Project> projects(@RequestParam(value = "valid", required = false) Optional<Boolean> valid,
                                  @RequestParam(value="property", required = false) Optional<ProjectRegInfo.Property> property,
                                  @RequestParam(value="class", required = false) Optional<ProjectRegInfo.ProjectClass> projectClass,
                                  @RequestParam(value = "important", required = false) Optional<ProjectRegInfo.ImportantType> important,
                                  @RequestParam(value ="page", required = false) Optional<Integer> page,
                                  @RequestParam(value ="key", required = false)Optional<String> key,
                                  @RequestParam(value ="sort", required = false)Optional<String> sort,
                                  @RequestParam(value ="dir", required = false)Optional<String> dir){
        return projectServices.projects(valid,property,projectClass,important,page,key,sort,dir);
    }


    @RequestMapping(value = "/project/{code}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @JsonView(Project.Details.class)
    public Project project(@PathVariable("code") long code){
        Optional<Project> result = projectServices.project(code);
        if (result.isPresent()){
            return result.get();
        }else{
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }


    @RequestMapping(value = "/join/{code}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @JsonView(JoinCorp.SummaryWithCorp.class)
    public List<JoinCorp> joinProjects(@PathVariable("code") long code){
        return projectServices.joinProjects(code);
    }


    @RequestMapping(value = "/reg/running/{code}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public String corpInReg(@PathVariable("code") long code){
        return String.valueOf(businessService.projectInReg(code));

    }

    @RequestMapping(value = "/project/{code}/build")
    public BuildReg buildRegByProject(@PathVariable("code") long code){
        return projectServices.getBuildRegByProject(code).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
    }
    
}
