package cc.coopersoft.construct.project.controllers;


import cc.coopersoft.construct.project.model.Project;
import cc.coopersoft.construct.project.model.ProjectReg;
import cc.coopersoft.construct.project.services.ProjectService;
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
public class ViewController {

    private final ProjectService projectService;

    @Autowired
    public ViewController(ProjectService projectService) {
        this.projectService = projectService;
    }

    @RequestMapping(value = "/projects", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @JsonView(Project.Summary.class)
    public Page<Project> projects(@RequestParam("valid") boolean valid,
                                  @RequestParam(value ="page", required = false) Optional<Integer> page,
                                  @RequestParam(value ="key", required = false)Optional<String> key,
                                  @RequestParam(value ="sort", required = false)Optional<String> sort,
                                  @RequestParam(value ="dir", required = false)Optional<String> dir){
        return projectService.projects(valid,page,key,sort,dir);
    }


    @RequestMapping(value = "/project/{code}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @JsonView(Project.Details.class)
    public Project project(@PathVariable("code") String code){
        Optional<Project> result = projectService.project(code);
        if (result.isPresent()){
            return result.get();
        }else{
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/reg/{id}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @JsonView(ProjectReg.Details.class)
    public ProjectReg reg(@PathVariable("id") String id){
        Optional<ProjectReg> result = projectService.reg(id);
        if (result.isPresent()){
            return result.get();
        }else{
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }

    }

    @RequestMapping(value = "/business/{code}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @JsonView(ProjectReg.Summary.class)
    public List<ProjectReg> joinProjects(@PathVariable("code") long code){
        return projectService.joinProjects(code);
    }


    
}
